//
//  JiraProject.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 24.10.18.
//


public extension Jira {

    class Project: Decodable {

        public let id: String
        public let key: String
        public let name: String

    }

}
