//
//  JiraSwiftTest.swift
//  JiraSwiftTests
//
//  Created by Sandro Wehrhahn on 05.03.19.
//


import XCTest


class JiraSwiftTest: XCTestCase  {

    func jiraCredentialsFromEnvironment() -> (URL, String, String) {
        guard let jiraUsername = ProcessInfo.processInfo.environment["jiraUsername"],
            let jiraPassword = ProcessInfo.processInfo.environment["jiraPassword"],
            let urlString = ProcessInfo.processInfo.environment["jiraURL"],
            let jiraURL = URL(string: urlString)
        else {
                fatalError()
        }

        return (jiraURL, jiraUsername, jiraPassword)
    }

    func jiraOAuthTokenFromCredentials() -> (URL, String) {
        guard let urlString = ProcessInfo.processInfo.environment["jiraURL"],
            let jiraURL = URL(string: urlString),
            let oAuthToken = ProcessInfo.processInfo.environment["jiraOAuthToken"]
        else {
                fatalError()
        }

        return (jiraURL, oAuthToken)
    }

}
