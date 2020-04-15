//
//  Routes+Search.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 15.04.20.
//


import Foundation
import NIO
import NIOHTTP1
import APIClient


public struct SearchRoutes: JiraRoutes {

    var handler: APIRouteHandler
    var authorizationValue: String

    public func post(request: SearchRequest) -> EventLoopFuture<SearchResult> {
        handler.post("/rest/api/2/search", headers: defaultHeader(), body: request)
    }

    public func post(jql: String, startAt: Int = 0, maxResults: Int = 50, fields: [SearchRequest.Field] = [],
                     expand: [String] = []) -> EventLoopFuture<SearchResult> {
        let searchRequest = SearchRequest(jql: jql, startAt: startAt, maxResults: maxResults,
                                          fields: fields, expand: expand)
        return post(request: searchRequest)
    }

}


//public extension Jira.Client {
//
//    func search(searchRequest: Jira.SearchRequest) -> EventLoopFuture<Jira.SearchResult> {
//        let request: HTTPClient.Request
//        do {
//            request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/search",
//                                             method: .POST,
//                                             headers: self.headers,
//                                             body: HTTPClient.Body.data(Jira.Client.jsonEncoder.encode(searchRequest)))
//        } catch {
//            return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
//        }
//        let searchResult: EventLoopFuture<Jira.SearchResult> = self.submit(request: request)
//        return searchResult
//    }
//
//    func search(jql: String,
//                startAt: Int = 0,
//                maxResults: Int = 50,
//                fields: [Jira.SearchRequest.Field] = [],
//                expand: [String] = []) -> EventLoopFuture<Jira.SearchResult> {
//        let searchRequest = Jira.SearchRequest(jql: jql,
//                                               startAt: startAt,
//                                               maxResults: maxResults,
//                                               fields: fields,
//                                               expand: expand)
//        return search(searchRequest: searchRequest)
//    }
//
//}
