//
//  JiraIssue.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

public extension Jira {
    class Issue: Decodable {
        public let id: String
        public let key: String
        public let fields: Fields
    }

    class Fields: Decodable {
        public let summary: String?
        public let project: Jira.Project
        public let components: [Component]
        public let assignee: Jira.User?
        public let creator: Jira.User
    }

    class Component: Decodable {
        public let id: String
        public let name: String
        public let selfUrl: String?
    }
}
