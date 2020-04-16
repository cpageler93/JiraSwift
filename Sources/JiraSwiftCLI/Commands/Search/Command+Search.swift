//
//  Command+Search.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 16.04.20.
//


import ArgumentParser
import Foundation
import SwiftyTextTable


extension JiraCLI {

    struct Search: ParsableCommand {

        static var configuration = CommandConfiguration(
            abstract: "Search actions"
        )

        @OptionGroup()
        var options: JiraCLI.Options

        @Option(name: .long, default: ProcessInfo.processInfo.environment["JIRA_JQL"], help: "Jira JQL")
        var jql: String

        func run() throws {
            let jira = try options.jiraClient()
            let searchResult = try jira.search.post(jql: jql, fields: [.creator, .assignee, .summary]).wait()

            var table = TextTable(columns: [
                TextTableColumn(header: "Key"),
                TextTableColumn(header: "Creator"),
                TextTableColumn(header: "Assignee"),
                TextTableColumn(header: "Summary")
            ], header: "Search Results")
            for issue in searchResult.issues {
                table.addRow(values: [
                    issue.key,
                    issue.fields.creator?.displayName ?? issue.fields.creator?.name ?? "",
                    issue.fields.assignee?.displayName ?? issue.fields.assignee?.name ?? "",
                    issue.fields.summary ?? ""
                ])
            }
            print(table.render())
        }
    }

}
