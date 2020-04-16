//
//  Command+Project+List.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 16.04.20.
//


import ArgumentParser
import SwiftyTextTable


extension JiraCLI.Project {

    struct List: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "list projects"
        )

        @OptionGroup()
        var options: JiraCLI.Options

        func run() throws {
            let jira = try options.jiraClient()
            let projects = try jira.project.list().wait()

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
            print(table.render())
        }
    }

}
