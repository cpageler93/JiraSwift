//
//  Routes+Project.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 15.04.20.
//


import Foundation
import NIO
import NIOHTTP1
import APIClient


public struct ProjectRoutes: JiraRoutes {

    var handler: APIRouteHandler
    var authorizationValue: String

    public func list() -> EventLoopFuture<[Project]> {
        handler.get("/rest/api/2/project", headers: defaultHeader())
    }

    public func types() -> EventLoopFuture<[ProjectType]> {
        handler.get("/rest/api/2/project/type", headers: defaultHeader())
    }

}
