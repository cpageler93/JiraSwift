//
//  JiraError.swift
//  
//
//  Created by Joe Smith on 9/25/19.
//

public extension Jira {
    class JiraResponseError: Decodable {
        public let errorMessages: [String]
    }
}
