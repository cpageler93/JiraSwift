//
//  Myself-Routes.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 28.09.19.
//


import AsyncHTTPClient
import NIO


public extension Jira.Client {

    func getMyself() -> EventLoopFuture<Jira.User> {
        let request: HTTPClient.Request
        do {
            request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/myself",
                                             method: .GET,
                                             headers: self.headers,
                                             body: nil)
        } catch {
            return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
        }
        let user: EventLoopFuture<Jira.User> = self.submit(request: request)
        return user
    }

}
