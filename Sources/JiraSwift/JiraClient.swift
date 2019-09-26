//
//  JiraClient.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

import Foundation

import AsyncHTTPClient
import NIO
import NIOHTTP1


public extension Jira {
    /// Errors communicating with JIRA
    enum ClientError: Swift.Error {
        case noBodyError(UInt)
        case couldNotReadBody
        case jiraError(Jira.JiraResponseError)
    }

    /// ➡ Class to communicate with JIRA
    class Client {
        static var dateFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return df
        }

        /// The underlying URL for the instance of JIRA
        private var baseURL: String

        /// All headers, typically for authentication, to be added to each request
        private var headers = HTTPHeaders([("Content-Type", "application/json")])

        /// The client powering all requests
        private var httpClient: HTTPClient
        
        public init(baseURL: String, username: String, password: String, eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew) {
            let base64Auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
            self.headers.add(name: "Authorization", value: "Basic \(base64Auth)")
            self.baseURL = baseURL
            self.httpClient = HTTPClient(eventLoopGroupProvider: eventLoopGroupProvider)
        }

        public init(baseURL: String, headers: [(String, String)], eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew) {
            for (name, value) in headers {
                self.headers.add(name: name, value: value)
            }
            self.baseURL = baseURL
            self.httpClient = HTTPClient(eventLoopGroupProvider: eventLoopGroupProvider)
        }

        public func submit<T: Decodable>(request: HTTPClient.Request) -> EventLoopFuture<T> {
            return self.httpClient.execute(request: request).flatMapThrowing { response in
                guard var body = response.body else {
                    throw ClientError.noBodyError(response.status.code)
                }

                guard let response = body.readBytes(length: body.readableBytes) else {
                    throw ClientError.couldNotReadBody
                }

                //print(String(data: Data(response), encoding: .utf8)!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) // Debugging

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Jira.Client.dateFormatter)

                // We try to convert to the right response type, if this doesn't work, we look if we
                // got an error message back from JIRA. If that doesn't appear to be the case, this
                // was likely a parsing error, so we should surface the original issue.
                do {
                    return try decoder.decode(T.self, from: Data(response))
                } catch {
                    guard let jiraError = try? ClientError.jiraError(decoder.decode(Jira.JiraResponseError.self, from: Data(response))) else {
                        throw error
                    }
                    throw jiraError
                }
            }
        }
        
        public func search(jql: String,
                           startAt: Int = 0,
                           maxResults: Int = 50,
                           fields: [String] = [],
                           expand: [String] = []) -> EventLoopFuture<Jira.SearchResult> {

            // https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/rest/v2/search/SearchRequestBean.html
            struct SearchRequest: Encodable {
                /// A JQL query string.
                let jql: String

                /// The index of the first issue to return (0-based).
                let startAt: Int

                /// The maximum number of issues to return (defaults to 50).
                let maxResults: Int

                /// The list of fields to return for each issue.
                let fields: [String]

                ///The list of issue parameters to expand on each issue.
                let expand: [String]

                /// Whether to validate the JQL query.
                let validateQuery: Bool = true
            }

            let searchRequest = SearchRequest(jql: jql, startAt: startAt, maxResults: maxResults, fields: fields, expand: expand)

            let request: HTTPClient.Request
            do {
                request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/search", method: .POST, headers: self.headers, body: HTTPClient.Body.data(JSONEncoder().encode(searchRequest)))
            } catch {
                return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
            }
            let searchResult: EventLoopFuture<Jira.SearchResult> = self.submit(request: request)
            return searchResult
        }
        
        /*public func updateRemoteLinkForIssue(withKey issueKey: String,
                                             link: String,
                                             title: String) -> EventLoopFuture<RemoteLink> {
            HTTPClient.Body.data(<#T##data: Data##Data#>)
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

            let request: HTTPClient.Request
            do {
                request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/issue/\(issueKey)/remotelink", method: .POST, headers: defaultHeader, body: nil)
            } catch {
                return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
            }
            let remoteLink: EventLoopFuture<Jira.RemoteLink> = self.submit(request: request)
            return remoteLink
        }*/

        public func getServerInfo() -> EventLoopFuture<Jira.ServerInfoResult> {
            let request: HTTPClient.Request
            do {
                request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/serverInfo", method: .GET, headers: self.headers, body: nil)
            } catch {
                return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
            }
            let serverInfo: EventLoopFuture<Jira.ServerInfoResult> = self.submit(request: request)
            return serverInfo
        }

        public func getMyself() -> EventLoopFuture<Jira.User> {
            let request: HTTPClient.Request
            do {
                request = try HTTPClient.Request(url: "\(self.baseURL)/rest/api/2/myself", method: .GET, headers: self.headers, body: nil)
            } catch {
                return self.httpClient.eventLoopGroup.next().makeFailedFuture(error)
            }
            let user: EventLoopFuture<Jira.User> = self.submit(request: request)
            return user
        }
    }
}
