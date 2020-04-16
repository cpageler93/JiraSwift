//
//  Commands+Project+Types.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 16.04.20.
//


import ArgumentParser
import SwiftyTextTable


extension JiraCLI.Project {

    struct Types: ParsableCommand {

        static var configuration = CommandConfiguration(
            abstract: "list project types"
        )

        @OptionGroup()
        var options: JiraCLI.Options

        func run() throws {
            let jira = try options.jiraClient()
            let projectTypes = try jira.project.types().wait()

            var table = TextTable(columns: [
                TextTableColumn(header: "Key"),
                TextTableColumn(header: "Formatted Key"),
                TextTableColumn(header: "Color")
            ], header: "Project Types")
            for projectType in projectTypes {
                table.addRow(values: [
                    projectType.key,
                    projectType.formattedKey,
                    projectType.color
                ])
            }
            print(table.render())
        }

    }

}
