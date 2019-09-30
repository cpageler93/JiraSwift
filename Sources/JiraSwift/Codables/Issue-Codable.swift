//
//  JiraIssue.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


import Foundation


public extension Jira {

    class Issue: Codable {

        public let id: String
        public let key: String
        public let fields: Fields

    }


    class Fields: Codable {

        public let summary: String?
        public let project: Jira.Project?
        public let status: Status?
        public let description: String?
        public let issuetype: IssueType?
        public let components: [Component]?
        public let assignee: Jira.User?
        public let creator: Jira.User?
        public let reporter: Jira.User?
        public let lastViewed: Date?
        public let created: Date?
        public let updated: Date?
        public let duedate: Date?
        public let resolution: Resolution?
        public let resolutiondate: Date?
        public let timespent: Int
        public let timeestimate: Int
        public let watches: Watches?
        public let versions: [Version]?
        public let fixVersions: [Version]?
        public let priority: Priority?

    }

    class Status: Codable {

        public let id: String
        public let name: String
        public let iconUrl: String
        public let description: String
        public let statusCategory: StatusCategory

        public class StatusCategory: Codable {

            public let id: Int
            public let key: String
            public let name: String
            public let colorName: String

        }
    }

    class Component: Codable {

        public let id: String
        public let name: String

    }

    class IssueType: Codable {

        public let id: String
        public let description: String
        public let iconUrl: String
        public let name: String
        public let subtask: Bool

    }

    class Resolution: Codable {

        public let id: String
        public let name: String
        public let description: String

    }

    class Watches: Codable {

        public let watchCount: Int
        public let isWatching: Bool

    }

    class Version: Codable {

        public let id: String
        public let description: String
        public let name: String
        public let archived: Bool
        public let released: Bool

        // TODO: Implement date parser without time
        // public let releaseDate: Date?

    }

    class Priority: Codable {

        public let id: String
        public let name: String
        public let iconUrl: String
    }
}
