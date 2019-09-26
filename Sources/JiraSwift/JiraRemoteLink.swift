//
//  JiraRemoteLink.swift
//  JiraSwiftPackageDescription
//
//  Created by Christoph Pageler on 19.02.18.
//

public extension Jira {
    class RemoteLink: Decodable {
        let id: Int
        let selfUrl: String
    }
}
