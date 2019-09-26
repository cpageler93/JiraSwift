//
//  JiraUser.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.10.18.
//

public extension Jira {
    class AvatarURLs: Decodable {
        public let sixteen: String
        public let twentyFour: String
        public let thirtyTwo: String
        public let fortyEight: String

        enum CodingKeys: String, CodingKey {
            case sixteen = "16x16"
            case twentyFour = "24x24"
            case thirtyTwo = "32x32"
            case fortyEight = "48x48"
        }
    }

    class User: Decodable {
        public let accountId: String?
        public let key: String
        public let name: String
        public let emailAddress: String
        public let displayName: String
        public let active: Bool
        public let timeZone: String
        public let avatarUrls: AvatarURLs
    }

}
