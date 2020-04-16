//
//  Command+Project.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 15.04.20.
//


import ArgumentParser


extension JiraCLI {

    struct Project: ParsableCommand {

        static var configuration = CommandConfiguration(
            abstract: "project actions",
            subcommands: [List.self, Types.self]
        )
        
    }

}
