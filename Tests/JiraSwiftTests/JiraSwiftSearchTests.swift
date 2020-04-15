//
//  JiraSwiftSearchTests.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.04.18.
//


//import XCTest
//@testable import JiraSwift
//
//
//class JiraSwiftSearchTests: JiraSwiftTest {
//    
//    static var allTests = [
//        ("testSearchShouldReturnSomeIssues", testSearchShouldReturnSomeIssues),
////        ("testClientSearchWithOAuthTokenShouldReturnSomeIssues", testClientSearchWithOAuthTokenShouldReturnSomeIssues),
//        ("testGetServerInfoShouldReturnServerInfo", testGetServerInfoShouldReturnServerInfo)
//    ]
//    
//    func testSearchShouldReturnSomeIssues() {
//        let (url, username, password) = jiraCredentialsFromEnvironment()
//        let jiraClient = Jira.Client(baseURL: url.absoluteString, username: username, password: password)
//        let seachResult = try! jiraClient.search(jql: "key in (EWE046-250, EWE046-249, EWE046-248)").wait()
//        XCTAssertEqual(seachResult.issues.count, 3)
//    }
//
//    func testSearchShouldReturnIssuesWithComponents() {
//        let (url, username, password) = jiraCredentialsFromEnvironment()
//        let jiraClient = Jira.Client(baseURL: url.absoluteString, username: username, password: password)
//        let searchResult = try! jiraClient.search(jql: "key in (SPEED-28, BA-10)").wait()
//
//        XCTAssertEqual(searchResult.issues.count, 2)
//        XCTAssertNotNil(searchResult.issues[0].fields.components)
//        XCTAssertNotNil(searchResult.issues[1].fields.components)
//    }
//
////    func testClientSearchWithOAuthTokenShouldReturnSomeIssues() {
////        let e = expectation(description: "searchExpecationWithOAuth")
////        let (url, token) = jiraOAuthTokenFromCredentials()
////        let jiraClient = Jira.Client(baseURL: url.absoluteString, headers: [("Authorization", token)])
////
////        jiraClient.search(jql: "key in (EWE027-65, EWE038-3, EWE027-58)").whenComplete { result in
////            switch result {
////            case .success(let result):
////                XCTAssertEqual(result.issues.count, 3)
////            case .failure:
////                XCTFail()
////            }
////            e.fulfill()
////        }
////
////        waitForExpectations(timeout: 15, handler: nil)
////    }
//
//    func testGetServerInfoShouldReturnServerInfo() {
//        let e = expectation(description: "serverInfoExpectation")
//        let (url, username, password) = jiraCredentialsFromEnvironment()
//        let jiraClient = Jira.Client(baseURL: url.absoluteString, username: username, password: password)
//        jiraClient.getServerInfo().whenComplete { result in
//            switch result {
//            case .success(let result):
//                XCTAssertNotNil(result)
//            case .failure:
//                XCTFail()
//            }
//            e.fulfill()
//
//        }
//
//        waitForExpectations(timeout: 15, handler: nil)
//    }
//
//    func testMyself() {
//        let e = expectation(description: "myselfExpectation")
//        let (url, username, password) = jiraCredentialsFromEnvironment()
//        let jiraClient = Jira.Client(baseURL: url.absoluteString, username: username, password: password)
//        jiraClient.getMyself().whenComplete { result in
//            switch result {
//            case .success(let result):
//                XCTAssertNotNil(result)
//            case .failure:
//                XCTFail()
//            }
//            e.fulfill()
//
//        }
//
//        waitForExpectations(timeout: 15, handler: nil)
//    }
//
//}
