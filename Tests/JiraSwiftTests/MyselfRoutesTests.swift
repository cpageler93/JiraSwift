//
//  MyselfRoutesTests.swift
//  JiraSwiftTests
//
//  Created by Christoph Pageler on 15.04.20.
//


import XCTest
import JiraSwift


class MyselfRoutesTests: JiraSwiftTest {

    func testGetMyself() throws {
        let jiraClient = jiraFromEnvironment()
        let myself = try jiraClient.myself.get().wait()
        XCTAssertNotNil(myself.displayName)
    }

}
