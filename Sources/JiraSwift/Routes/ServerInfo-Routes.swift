//
//  ServerInfo-Routes.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 28.09.19.
//


import AsyncHTTPClient
import NIO


public extension Jira.Client {

    func getServerInfo() -> EventLoopFuture<Jira.ServerInfoResult> {
        let request: HTTPClient.Request
        do {
            request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/serverInfo",
                                             method: .GET,
                                             headers: self.headers,
                                             body: nil)
        } catch {
            return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
        }
        let serverInfo: EventLoopFuture<Jira.ServerInfoResult> = self.submit(request: request)
        return serverInfo
    }

}
