//
//  JiraCLI.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 11.04.18.
//


import ArgumentParser
import Foundation
import JiraSwift


struct JiraCLI: ParsableCommand {

    static var configuration = CommandConfiguration(
        abstract: "A jira command line interface",
        subcommands: [Project.self, Search.self]
    )

    struct Options: ParsableArguments {

        @Option(name: .long, default: ProcessInfo.processInfo.environment["JIRA_URL"], help: "Jira URL, for example: https://your_jira_url.com")
        var url: String

        @Option(name: .long, default: ProcessInfo.processInfo.environment["JIRA_USERNAME"], help: "Jira username")
        var username: String

        @Option(name: .long, default: ProcessInfo.processInfo.environment["JIRA_PASSWORD"], help: "Jira password")
        var password: String

        func jiraClient() throws -> JiraClient {
            guard let baseURL = URL(string: url) else {
                throw JiraCLIError.notAnURL
            }
            return JiraClient(baseURL: baseURL, username: username, password: password)
        }
    }

}
