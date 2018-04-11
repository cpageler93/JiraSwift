//
//  JiraSearchResult.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

import Foundation
import Quack


public extension Jira {
    
    public class SearchResult: Quack.Model {
        
        public let expand: String?
        public let startAt: Int
        public let maxResults: Int
        public let total: Int
        public let issues: [Issue]
        
        public required init?(json: JSON) {
            guard let startAt = json["startAt"].int,
                let maxResults = json["maxResults"].int,
                let total = json["total"].int
            else {
                return nil
            }
            self.expand = json["expand"].string
            self.startAt = startAt
            self.maxResults = maxResults
            self.total = total
            self.issues = json["issues"].array?.flatMap { Issue(json: $0) } ?? []
        }
        
    }

    
}
