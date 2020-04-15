//
//  JiraSwiftCLI.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 11.04.18.
//


import ArgumentParser


struct JiraCLI: ParsableCommand {

    static var configuration = CommandConfiguration(
        abstract: "A jira command line interface",
        subcommands: [Project.self]
    )

    struct Options: ParsableArguments {
        @Flag(name: [.long, .customShort("x")], help: "Use hexadecimal notation for the result.")
        var hexadecimalOutput: Bool

        @Argument(help: "A group of integers to operate on.")
        var values: [Int]
    }

}


//import Foundation
//import ConsoleKit
//import JiraSwift
//
//
//public class JiraSwiftCLI {
//
//    public func run() {
//        do {
//            var config = CommandConfiguration()
//
//            config.use(SearchCommand(), as: "search")
//            config.use(ProjectsCommand(), as: "projects")
//            config.use(ProjectTypesCommand(), as: "project-types")
//
//            let group = try config.resolve().group()
//            let commandInput = CommandInput(arguments: CommandLine.arguments)
//
//            let terminal = Terminal()
//            try terminal.run(group, input: commandInput)
//        } catch {
//            switch error {
//            case let httpError as Jira.ClientError:
//                switch httpError {
//                case .noBodyError(let statusCode):
//                    print("No Body (\(statusCode))")
//                case .couldNotReadBody:
//                    print("Could not read body")
//                case .httpError(let statusCode):
//                    print("HTTP Error: \(statusCode)")
//                case .jiraError(let jiraResponseError):
//                    print("JIRA Error: \(jiraResponseError.errorMessages)")
//                }
//            default: print("Unknown error")
//            }
//        }
//    }
//
//}
