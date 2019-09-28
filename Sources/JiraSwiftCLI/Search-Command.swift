//
//  Search-Command.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 11.04.18.
//


import Foundation
import ConsoleKit
import JiraSwift
import SwiftyTextTable


struct SearchCommand: Command {

    public struct SearchCommandSignature: CommandSignature {
        @Option(name: "url", help: "Set the url of your jira instace")
        var url: String

        @Option(name: "username", short: "u", help: "Set your jira username")
        var username: String

        @Option(name: "password", short: "p", help: "Set your jira password")
        var password: String

        @Option(name: "jql", short: "j", help: "Set the JQL Query to execute")
        var jql: String

        public init() { }
    }

    public typealias Signature = SearchCommandSignature

    public var help: String {
        ""
    }

    public func run(using context: CommandContext, signature: SearchCommand.Signature) throws {
        guard let jiraURL = signature.url,
            let username = signature.username,
            let password = signature.password,
            let jql = signature.jql
        else {
            var context = context
            outputHelp(using: &context)
            return
        }
        let loading = context.console.loadingBar(title: "Searching")
        loading.start()

        let client = Jira.Client(baseURL: jiraURL, username: username, password: password)
        let searchResult = try client.search(jql: jql).wait()

        loading.succeed()

        var table = TextTable(columns: [
            TextTableColumn(header: "Key"),
            TextTableColumn(header: "Creator"),
            TextTableColumn(header: "Assignee"),
            TextTableColumn(header: "Summary")
        ], header: "Search Result")
        for issue in searchResult.issues {
            table.addRow(values: [
                issue.key,
                issue.fields.creator.name,
                issue.fields.assignee?.name ?? "",
                issue.fields.summary ?? ""
            ])
        }
        context.console.print(table.render())
    }

}
