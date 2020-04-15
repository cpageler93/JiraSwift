//
//  JiraIssue.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


import Foundation


public struct Issue: Codable {

    public var id: String
    public var key: String
    public var fields: Fields

}


public struct Fields: Codable {

    public var summary: String?
    public var project: Project?
    public var status: Status?
    public var description: String?
    public var issuetype: IssueType?
    public var components: [Component]?
    public var assignee: User?
    public var creator: User?
    public var reporter: User?
    public var lastViewed: Date?
    public var created: Date?
    public var updated: Date?
    public var duedate: Date?
    public var resolution: Resolution?
    public var resolutiondate: Date?
    public var timespent: Int?
    public var timeestimate: Int?
    public var watches: Watches?
    public var versions: [Version]?
    public var fixVersions: [Version]?
    public var priority: Priority?

}


public struct Status: Codable {

    public var id: String
    public var name: String
    public var iconUrl: String
    public var description: String
    public var statusCategory: StatusCategory

    public struct StatusCategory: Codable {

        public var id: Int
        public var key: String
        public var name: String
        public var colorName: String

    }
}


public struct Component: Codable {

    public var id: String
    public var name: String

}


public struct IssueType: Codable {

    public var id: String
    public var description: String
    public var iconUrl: String
    public var name: String
    public var subtask: Bool

}


public struct Resolution: Codable {

    public var id: String
    public var name: String
    public var description: String

}


public struct Watches: Codable {

    public var watchCount: Int
    public var isWatching: Bool

}


public struct Version: Codable {

    public var id: String
    public var description: String
    public var name: String
    public var archived: Bool
    public var released: Bool

    // TODO: Implement date parser without time
    // public let releaseDate: Date?

}


public struct Priority: Codable {

    public var id: String
    public var name: String
    public var iconUrl: String

}
