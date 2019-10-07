//
//  ProjectTypes-Command.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 30.09.19.
//


import Foundation
import ConsoleKit
import JiraSwift
import SwiftyTextTable


struct ProjectTypesCommand: Command {

    public struct ProjectTypesSignature: CommandSignature, ClientCreatableCommandSignature {

        @Option(name: "url", help: "Set the url of your jira instace")
        var url: String

        @Option(name: "username", short: "u", help: "Set your jira username")
        var username: String

        @Option(name: "password", short: "p", help: "Set your jira password")
        var password: String

        public init() { }
    }

    public typealias Signature = ProjectTypesSignature

    public var help: String {
        "Lists all project types"
    }

    public func run(using context: CommandContext, signature: Signature) throws {
        guard let client = signature.client() else {
            var context = context
            outputHelp(using: &context)
            return
        }

        let loading = context.console.loadingBar(title: "Searching")
        loading.start()

        let projectTypes = try client.projectTypes().wait()
        loading.succeed()

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
        context.console.print(table.render())
    }

}
