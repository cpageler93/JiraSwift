//
//  SearchRoutes.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 27.09.19.
//


import AsyncHTTPClient
import NIO


public extension Jira.Client {

    func search(searchRequest: Jira.SearchRequest) -> EventLoopFuture<Jira.SearchResult> {
        let request: HTTPClient.Request
        do {
            request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/search",
                                             method: .POST,
                                             headers: self.headers,
                                             body: HTTPClient.Body.data(Jira.Client.jsonEncoder.encode(searchRequest)))
        } catch {
            return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
        }
        let searchResult: EventLoopFuture<Jira.SearchResult> = self.submit(request: request)
        return searchResult
    }

    func search(jql: String,
                startAt: Int = 0,
                maxResults: Int = 50,
                fields: [String] = [],
                expand: [String] = []) -> EventLoopFuture<Jira.SearchResult> {
        let searchRequest = Jira.SearchRequest(jql: jql,
                                               startAt: startAt,
                                               maxResults: maxResults,
                                               fields: fields,
                                               expand: expand)
        return search(searchRequest: searchRequest)
    }

}
