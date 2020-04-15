//
//  Routes+Myself.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 15.04.20.
//


import Foundation
import NIO
import NIOHTTP1
import APIClient


public struct MyselfRoutes: JiraRoutes {

    var handler: APIRouteHandler
    var authorizationValue: String

    public func get() -> EventLoopFuture<User> {
        handler.get("/rest/api/2/myself", headers: defaultHeader())
    }

}
