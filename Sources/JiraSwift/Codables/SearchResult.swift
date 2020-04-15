//
//  JiraSearchResult.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


public struct SearchResult: Codable {

    public var expand: String?
    public var startAt: Int
    public var maxResults: Int
    public var total: Int
    public var issues: [Issue]

}
