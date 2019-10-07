//
//  JiraSearchResult.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


public extension Jira {

    class SearchResult: Decodable {

        public let expand: String?
        public let startAt: Int
        public let maxResults: Int
        public let total: Int
        public let issues: [Issue]

    }

}
