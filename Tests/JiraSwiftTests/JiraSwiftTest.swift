//
//  JiraSwiftTest.swift
//  JiraSwiftTests
//
//  Created by Sandro Wehrhahn on 05.03.19.
//


import XCTest


class JiraSwiftTest: XCTestCase  {

    func jiraCredentialsFromEnvironment() -> (URL, String, String) {
        guard let jiraUsername = ProcessInfo.processInfo.environment["JIRA_USERNAME"],
            let jiraPassword = ProcessInfo.processInfo.environment["JIRA_PASSWORD"],
            let urlString = ProcessInfo.processInfo.environment["JIRA_URL"],
            let jiraURL = URL(string: urlString)
        else {
            fatalError()
        }

        return (jiraURL, jiraUsername, jiraPassword)
    }

    func jiraOAuthTokenFromCredentials() -> (URL, String) {
        guard let urlString = ProcessInfo.processInfo.environment["JIRA_URL"],
            let jiraURL = URL(string: urlString),
            let oAuthToken = ProcessInfo.processInfo.environment["JIRA_OAUTH_TOKEN"]
        else {
            fatalError()
        }

        return (jiraURL, oAuthToken)
    }

}
