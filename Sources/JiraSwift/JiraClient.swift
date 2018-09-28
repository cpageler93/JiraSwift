//
//  JiraClient.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

import Foundation
import Quack


public extension Jira {
    
    public class Client: Quack.Client {
        
        private var authorizationHeaderValue: String
        
        private var defaultHeader: [String: String] {
            return [
                "Authorization": authorizationHeaderValue,
                "Content-Type": "application/json"
            ]
        }
        
        public init(url: URL, username: String, password: String) {
            let base64Auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
            self.authorizationHeaderValue = "Basic \(base64Auth)"
            super.init(url: url)
        }

        public init(url: URL, oAuthAccessToken: String) {
            self.authorizationHeaderValue = "Bearer \(oAuthAccessToken)"
            super.init(url: url)
        }
        
        public func search(jql: String,
                           startAt: Int = 0,
                           maxResults: Int = 50,
                           fields: [String] = [],
                           fieldsByKeys: Bool = false) -> Quack.Result<SearchResult> {
            let body: [String: Any] = [
                "jql": jql,
                "startAt": startAt,
                "maxResults": maxResults,
                "fields": fields,
                "fieldsByKeys": fieldsByKeys
            ]
            
            return respond(method: .post,
                           path: "/rest/api/2/search",
                           body: Quack.JSONBody(body),
                           headers: defaultHeader,
                           model: SearchResult.self,
                           requestModification: { request in
                               var request = request
                               request.encoding = .json
                               return request
                           })
        }
        
        public func search(jql: String,
                           startAt: Int = 0,
                           maxResults: Int = 50,
                           fields: [String] = [],
                           fieldsByKeys: Bool = false,
                           completion: @escaping (Quack.Result<SearchResult>) -> ()) {
            let body: [String: Any] = [
                "jql": jql,
                "startAt": startAt,
                "maxResults": maxResults,
                "fields": fields,
                "fieldsByKeys": fieldsByKeys
            ]
            
            return respondAsync(method: .post,
                                path: "/rest/api/2/search",
                                body: Quack.JSONBody(body),
                                headers: defaultHeader,
                                model: SearchResult.self,
                                requestModification: { request in
                                    var request = request
                                    request.encoding = .json
                                    return request
                                },
                                completion: completion)
            
        }
        
        public func updateRemoteLinkForIssue(withKey issueKey: String,
                                             link: String,
                                             title: String) -> Quack.Result<RemoteLink> {
            let body: [String : Any] = [
                "application": [
                    "type": "com.thepeaklab.jiraSwift",
                    "name": "Jira Swift Client"
                ],
                "relationship": "mentioned in",
                "object": [
                    "url": link,
                    "title": title
                ]
            ]
            
            return respond(method: .post,
                           path: "/rest/api/2/issue/\(issueKey)/remotelink",
                           body: Quack.JSONBody(body),
                           headers: defaultHeader,
                           model: RemoteLink.self)
        }
        
        public func updateRemoteLinkForIssue(withKey issueKey: String,
                                             link: String,
                                             title: String,
                                             completion: @escaping (Quack.Result<RemoteLink>) -> ()) {
            let body: [String : Any] = [
                "application": [
                    "type": "com.thepeaklab.jiraSwift",
                    "name": "Jira Swift Client"
                ],
                "relationship": "mentioned in",
                "object": [
                    "url": link,
                    "title": title
                ]
            ]
            
            return respondAsync(method: .post,
                                path: "/rest/api/2/issue/\(issueKey)/remotelink",
                                body: Quack.JSONBody(body),
                                headers: defaultHeader,
                                model: RemoteLink.self,
                                completion: completion)
        }

        public func getServerInfo() -> Quack.Result<ServerInfoResult> {
            return respond(method: .get,
                           path: "/rest/api/2/serverInfo",
                           headers: defaultHeader,
                           model: ServerInfoResult.self)
        }

        public func getServerInfo(completion: @escaping (Quack.Result<ServerInfoResult>) -> ()) {
            return respondAsync(method: .get,
                                path: "/rest/api/2/serverInfo",
                                headers: defaultHeader,
                                model: ServerInfoResult.self,
                                completion: completion)
        }
        
    }
    
}
