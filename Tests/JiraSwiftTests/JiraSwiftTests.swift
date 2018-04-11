//
//  JiraSwiftTests.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.04.18.
//


import XCTest
@testable import JiraSwift


class JiraSwiftTests: XCTestCase {
    
    static var allTests = [
        ("testExample", testExample),
    ]
    
    func testExample() {
        let e = expectation(description: "searchExpecation")
        let jiraClient = Jira.Client(url: URL(string: "https://thepeaklab.atlassian.net")!,
                                     username: "c.pageler",
                                     password: "BUD03mne!")
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
