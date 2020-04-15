//
//  JiraRoutes.swift
//  APIClient
//
//  Created by Christoph Pageler on 15.04.20.
//


import APIClient
import NIOHTTP1


protocol JiraRoutes {

    var handler: APIRouteHandler { get set }
    var authorizationValue: String { get set }

    init(handler: APIRouteHandler, authorizationValue: String)

    func defaultHeader() -> HTTPHeaders

}


extension JiraRoutes {

    func defaultHeader() -> HTTPHeaders {
        handler.headers(authorizationValue: authorizationValue)
    }

}
