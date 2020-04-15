//
//  ProjectRoutesTests.swift
//  JiraSwiftTests
//
//  Created by Christoph Pageler on 15.04.20.
//


import XCTest
import JiraSwift


class ProjectRoutesTests: JiraSwiftTest {

    func testProjectList() throws {
        let jiraClient = jiraFromEnvironment()
        let projects = try jiraClient.proqject.list().wait()
        XCTAssertGreaterThan(projects.count, 1)
    }

    func testProjectTypes() throws {
        let jiraClient = jiraFromEnvironment()
        let projectTypes = try jiraClient.project.types().wait()
        XCTAssertGreaterThan(projectTypes.count, 1)
    }

}
