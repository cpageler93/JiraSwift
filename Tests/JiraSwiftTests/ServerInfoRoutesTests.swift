//
//  ServerInfoRoutesTests.swift
//  JiraSwiftTests
//
//  Created by Christoph Pageler on 15.04.20.
//


import XCTest
import JiraSwift


class ServerInfoRoutesTests: JiraSwiftTest {

    func testGetServerInfo() throws {
        let jiraClient = jiraFromEnvironment()
        let serverInfo = try jiraClient.serverInfo.get().wait()
        XCTAssertNotNil(serverInfo.baseUrl)
    }

}
