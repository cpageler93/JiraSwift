//
//  APIRouteHandler+Extensions.swift
//  APIClient
//
//  Created by Christoph Pageler on 15.04.20.
//


import Foundation
import APIClient
import NIOHTTP1


extension APIRouteHandler {

    public func headers(basicAuth: String?, other: [String: String]? = [:]) -> HTTPHeaders {
        var headers = other ?? [:]
        if let basicAuth = basicAuth {
            headers["Authorization"] = "Basic \(basicAuth)"
        }
        return self.headers(headers)
    }

    public func headers(authorizationValue: String, other: [String: String]? = [:]) -> HTTPHeaders {
        return self.headers([
            "Authorization": authorizationValue
        ])
    }


}
