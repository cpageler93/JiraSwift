//
//  Projects-Command.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 30.09.19.
//


import Foundation
import ConsoleKit
import JiraSwift
import SwiftyTextTable


struct ProjectsCommand: Command {

    public struct ProjectsSignature: CommandSignature, ClientCreatableCommandSignature {

        @Option(name: "url", help: "Set the url of your jira instace")
        var url: String

        @Option(name: "username", short: "u", help: "Set your jira username")
        var username: String

        @Option(name: "password", short: "p", help: "Set your jira password")
        var password: String

        public init() { }
    }

    public typealias Signature = ProjectsSignature

    public var help: String {
        "Lists all projects"
    }

    public func run(using context: CommandContext, signature: Signature) throws {
        guard let client = signature.client() else {
            var context = context
            outputHelp(using: &context)
            return
        }

        let loading = context.console.loadingBar(title: "Searching")
        loading.start()

        let projects = try client.projects().wait()
        loading.succeed()

        var table = TextTable(columns: [
            TextTableColumn(header: "Key"),
            TextTableColumn(header: "Name"),
            TextTableColumn(header: "Project Type Key")
        ], header: "Projects")
        for project in projects {
            table.addRow(values: [
                project.key,
                project.name,
                project.projectTypeKey
            ])
        }
        context.console.print(table.render())
    }

}
