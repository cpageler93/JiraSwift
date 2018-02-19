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
    
    public init(url: URL, authorizationHeaderValue: String) {
        self.authorizationHeaderValue = authorizationHeaderValue
        super.init(url: url)
    }
    
    public func search(jql: String,
                       startAt: Int = 0,
                       maxResults: Int = 50,
                       fields: [String] = [],
                       fieldsByKeys: Bool = false) -> QuackResult<JiraSearchResult> {
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
        
        return respond(method: .post,
                       path: "/rest/api/2/search",
                       body: body,
                       headers: headers,
                       model: JiraSearchResult.self)
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
    
    public func updateRemoteLinkForIssue(withKey issueKey: String,
                                         link: String,
                                         title: String) -> QuackResult<JiraRemoteLink> {
        let headers = [
            HeaderKey("Authorization"): authorizationHeaderValue,
            HeaderKey("Content-Type"): "application/json",
        ] as [HeaderKey: String]
        
        let body = [
            "application": [
                "type": "com.thepeaklab.jiraSwift",
                "name": "Jira Swift Client"
            ],
            "relationship": "mentioned in",
            "object": [
                "url": link,
                "title": title
            ]
            
        ] as [String : Any]
        
        return respond(method: .post,
                       path: "/rest/api/2/issue/\(issueKey)/remotelink",
                       body: body,
                       headers: headers,
                       model: JiraRemoteLink.self)
    }
    
    public func updateRemoteLinkForIssue(withKey issueKey: String,
                                         link: String,
                                         title: String,
                                         completion: @escaping (QuackResult<JiraRemoteLink>) -> ()) {
        let headers = [
            HeaderKey("Authorization"): authorizationHeaderValue,
            HeaderKey("Content-Type"): "application/json",
        ] as [HeaderKey: String]
        
        let body = [
            "application": [
                "type": "com.thepeaklab.jiraSwift",
                "name": "Jira Swift Client"
            ],
            "relationship": "mentioned in",
            "object": [
                "url": link,
                "title": title
            ]
            
        ] as [String : Any]
        
        return respondAsync(method: .post,
                            path: "/rest/api/2/issue/\(issueKey)/remotelink",
                            body: body,
                            headers: headers,
                            model: JiraRemoteLink.self,
                            completion: completion)
    }
    
}
