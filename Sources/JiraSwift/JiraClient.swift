//
//  JiraClient.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

import Foundation
import Quack
import HTTP

public class JiraClient: QuackClient {
    
    private var authorizationHeaderValue: String
    
    init(url: URL, authorizationHeaderValue: String) {
        self.authorizationHeaderValue = authorizationHeaderValue
        super.init(url: url)
    }
    
    public func search(jql: String,
                       startAt: Int = 0,
                       maxResults: Int = 50,
                       fields: [String] = [],
                       fieldsByKeys: Bool = false,
                       completion: @escaping (QuackResult<JiraSearchResult>) -> ()) {
        
        let headers = [
            HeaderKey("Authorization"): authorizationHeaderValue,
            HeaderKey("Content-Type"): "application/json",
        ] as [HeaderKey: String]
        
        let body = [
            "jql": jql,
            "startAt": "\(startAt)",
            "maxResults": "\(maxResults)",
            "fields": fields,
            "fieldsByKeys": fieldsByKeys
        ] as [String : Any]
        
        respondAsync(method: .post,
                     path: "/rest/api/2/search",
                     body: body,
                     headers: headers,
                     model: JiraSearchResult.self,
                     completion: completion)
        
    }
    
}
