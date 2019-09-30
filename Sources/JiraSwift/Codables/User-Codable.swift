//
//  JiraUser.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.10.18.
//


public extension Jira {

    class User: Codable {

        public let accountId: String?
        public let key: String
        public let name: String
        public let emailAddress: String?
        public let displayName: String
        public let active: Bool
        public let timeZone: String
        public let avatarUrls: AvatarURLs

    }

}
