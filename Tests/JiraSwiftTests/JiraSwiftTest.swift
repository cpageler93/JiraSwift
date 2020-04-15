//
//  JiraSwiftTest.swift
//  JiraSwiftTests
//
//  Created by Sandro Wehrhahn on 05.03.19.
//


import XCTest
import JiraSwift


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

    func jiraOAuthTokenFromEnvironment() -> (URL, String) {
        guard let urlString = ProcessInfo.processInfo.environment["JIRA_URL"],
            let jiraURL = URL(string: urlString),
            let oAuthToken = ProcessInfo.processInfo.environment["JIRA_OAUTH_TOKEN"]
        else {
            fatalError()
        }

        return (jiraURL, oAuthToken)
    }

    func jiraFromEnvironment() -> JiraClient {
        let credentials = jiraCredentialsFromEnvironment()
        return JiraClient(baseURL: credentials.0, username: credentials.1, password: credentials.2)
//        let credentials = jiraOAuthTokenFromEnvironment()
//        return JiraClient(baseURL: credentials.0, token: credentials.1)
    }

}
