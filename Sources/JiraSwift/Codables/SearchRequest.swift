//
//  JiraSearchRequest.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 28.09.19.
//


import Foundation


// https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/rest/v2/search/SearchRequestBean.html
public struct SearchRequest: Codable {

    /// A JQL query string.
    public var jql: String

    /// The index of the first issue to return (0-based).
    public var startAt: Int

    /// The maximum number of issues to return (defaults to 50).
    public var maxResults: Int

    /// The list of fields to return for each issue.
    public var fields: [Field]

    /// The list of issue parameters to expand on each issue.
    public var expand: [String]

    /// Whether to validate the JQL query.
    public var validateQuery: Bool = true

    public enum Field: String, Codable {

        case summary
        case project
        case status
        case description
        case issuetype
        case components
        case assignee
        case creator
        case reporter
        case lastViewed
        case created
        case updated
        case duedate
        case resolution
        case resolutiondate
        case timespent
        case timeestimate
        case watches
        case versions
        case fixVersions
        case priority

    }

}
