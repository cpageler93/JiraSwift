//
//  SearchRoutesTests.swift
//  JiraSwiftTests
//
//  Created by Christoph Pageler on 15.04.20.
//


import XCTest
import JiraSwift


class SearchRoutesTests: JiraSwiftTest {

    func testSearch() throws {
        let jiraClient = jiraFromEnvironment()
        let searchResult = try jiraClient.search.post(jql: "order by lastViewed DESC").wait()
        XCTAssertGreaterThan(searchResult.issues.count, 0)
    }

}
