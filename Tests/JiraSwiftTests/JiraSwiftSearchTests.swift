//
//  JiraSwiftSearchTests.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.04.18.
//


import XCTest
@testable import JiraSwift

class JiraSwiftSearchTests: JiraSwiftTest {
    
    static var allTests = [
        ("testSearchShouldReturnSomeIssues", testSearchShouldReturnSomeIssues),
        ("testClientSearchWithOAuthTokenShouldReturnSomeIssues", testClientSearchWithOAuthTokenShouldReturnSomeIssues),
        ("testGetServerInfoShouldReturnServerInfo", testGetServerInfoShouldReturnServerInfo)
    ]
    
    func testSearchShouldReturnSomeIssues() {
        let e = expectation(description: "searchExpecation")
        let (url, username, password) = jiraCredentialsFromEnvironment()
        let jiraClient = Jira.Client(url: url, username: username, password: password)
        jiraClient.search(jql: "key in (EWE27-65, EWE038-3, EWE027-58)") { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result.issues.count, 3)
            case .failure:
                XCTFail()
            }
            e.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }

    func testSearchShouldReturnIssuesWithComponents() {
        let e = expectation(description: "searchWithComponentsExpecation")
        let (url, username, password) = jiraCredentialsFromEnvironment()
        let jiraClient = Jira.Client(url: url, username: username, password: password)
        jiraClient.search(jql: "key in (SPEED-28, BA-10)") { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result.issues.count, 2)
                XCTAssertFalse(result.issues[0].fields.components.isEmpty)
                XCTAssertFalse(result.issues[1].fields.components.isEmpty)
            case .failure:
                XCTFail()
            }
            e.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testClientSearchWithOAuthTokenShouldReturnSomeIssues() {
        let e = expectation(description: "searchExpecationWithOAuth")
        let (url, token) = jiraOAuthTokenFromCredentials()
        let jiraClient = Jira.Client(url: url, oAuthAccessToken: token)

        jiraClient.search(jql: "key in (EWE027-65, EWE038-3, EWE027-58)") { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result.issues.count, 3)
            case .failure:
                XCTFail()
            }
            e.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testGetServerInfoShouldReturnServerInfo() {
        let e = expectation(description: "serverInfoExpectation")
        let (url, username, password) = jiraCredentialsFromEnvironment()
        let jiraClient = Jira.Client(url: url, username: username, password: password)
        jiraClient.getServerInfo { result in
            switch result {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure:
                XCTFail()
            }
            e.fulfill()

        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testMyself() {
        let e = expectation(description: "myselfExpectation")
        let (url, username, password) = jiraCredentialsFromEnvironment()
        let jiraClient = Jira.Client(url: url, username: username, password: password)
        jiraClient.getMyself() { result in
            switch result {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure:
                XCTFail()
            }
            e.fulfill()

        }

        waitForExpectations(timeout: 15, handler: nil)
    }

}
