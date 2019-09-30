//
//  JiraProject.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 24.10.18.
//


public extension Jira {

    class Project: Codable {

        public let id: String
        public let key: String
        public let name: String
        public let projectTypeKey: String
        public let avatarUrls: AvatarURLs

    }

    class ProjectType: Codable {

        public let key: String
        public let formattedKey: String
        public let descriptionI18nKey: String
        public let icon: String
        public let color: String
    }

}
