//
//  Jira.swift
//  JiraSwift
//
//  Created by Robert Feldhus on 24.09.18.
//

import Foundation

public extension Jira {
    class ServerInfoResult: Decodable {
        public let baseUrl: String
        public let version: String
        public let versionNumbers: [Int]
        public let deploymentType: String
        public let buildNumber: Int
        public let buildDate: Date
        public let serverTime: Date
        public let scmInfo: String
        public let serverTitle: String
    }
}
