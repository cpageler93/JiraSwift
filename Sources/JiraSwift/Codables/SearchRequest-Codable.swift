//
//  JiraSearchRequest.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 28.09.19.
//


import Foundation


public extension Jira {

    // https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/rest/v2/search/SearchRequestBean.html
    struct SearchRequest: Codable {

        /// A JQL query string.
        let jql: String

        /// The index of the first issue to return (0-based).
        let startAt: Int

        /// The maximum number of issues to return (defaults to 50).
        let maxResults: Int

        /// The list of fields to return for each issue.
        let fields: [String]

        ///The list of issue parameters to expand on each issue.
        let expand: [String]

        /// Whether to validate the JQL query.
        let validateQuery: Bool = true
        
    }

}
