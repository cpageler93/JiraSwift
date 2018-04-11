//
//  JiraSwiftSearchTests.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.04.18.
//


import XCTest
@testable import JiraSwift


class JiraSwiftSearchTests: XCTestCase {
    
    static var allTests = [
        ("testSearchShouldReturnSomeIssues", testSearchShouldReturnSomeIssues),
    ]
    
    func testSearchShouldReturnSomeIssues() {
        let e = expectation(description: "searchExpecation")
        let jiraClient = Jira.Client(url: URL(string: "your_jira_url")!,
                                     username: "your_username",
                                     password: "your_password")
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

}
