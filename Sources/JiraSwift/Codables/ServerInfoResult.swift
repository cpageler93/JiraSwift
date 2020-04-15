//
//  Jira.swift
//  JiraSwift
//
//  Created by Robert Feldhus on 24.09.18.
//


import Foundation


public struct ServerInfoResult: Codable {

    public var baseUrl: String
    public var version: String
    public var versionNumbers: [Int]
    public var deploymentType: String
    public var buildNumber: Int
    public var buildDate: Date
    public var serverTime: Date
    public var scmInfo: String
    public var serverTitle: String

}
