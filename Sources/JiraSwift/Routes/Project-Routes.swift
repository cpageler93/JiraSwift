//
//  Project-Routes.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 30.09.19.
//


import AsyncHTTPClient
import NIO


public extension Jira.Client {

    func projects() -> EventLoopFuture<[Jira.Project]> {
        do {
            let request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/project",
                                                 method: .GET,
                                                 headers: headers)
            return submit(request: request)
        } catch {
            return httpClient.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    func projectTypes() -> EventLoopFuture<[Jira.ProjectType]> {
        do {
            let request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/project/type",
                                                 method: .GET,
                                                 headers: headers)
            return submit(request: request)
        } catch {
            return httpClient.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

}
