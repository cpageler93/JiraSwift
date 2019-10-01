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
        case httpError(UInt)
        case jiraError(Jira.JiraResponseError)

    }

    /// ➡ Class to communicate with JIRA
    class Client {

        static var dateFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return df
        }

        static var jsonDecoder: JSONDecoder {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Jira.Client.dateFormatter)
            return decoder
        }

        static var jsonEncoder: JSONEncoder {
            let decoder = JSONEncoder()
            decoder.dateEncodingStrategy = .formatted(Jira.Client.dateFormatter)
            return decoder
        }

        /// The underlying URL for the instance of JIRA
        internal var baseURL: String

        /// All headers, typically for authentication, to be added to each request
        internal var headers = HTTPHeaders([("Content-Type", "application/json")])

        /// The client powering all requests
        internal var httpClient: HTTPClient

        public init(baseURL: String,
                    headers: [(String, String)],
                    eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew) {
            for (name, value) in headers {
                self.headers.add(name: name, value: value)
            }
            self.baseURL = baseURL
            self.httpClient = HTTPClient(eventLoopGroupProvider: eventLoopGroupProvider)
        }

        deinit {
            try? httpClient.syncShutdown()
        }

        public convenience init(baseURL: String,
                                username: String,
                                password: String,
                                eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider = .createNew) {
            let base64Auth = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
            self.init(baseURL: baseURL,
                      headers: [("Authorization", "Basic \(base64Auth)")],
                      eventLoopGroupProvider: eventLoopGroupProvider)
        }

        func submit<T: Decodable>(request: HTTPClient.Request) -> EventLoopFuture<T> {
            return httpClient.execute(request: request).flatMapThrowing { response in
                guard response.status.code < 400 else {
                    throw ClientError.httpError(response.status.code)
                }
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
                    return try Client.jsonDecoder.decode(T.self, from: Data(response))
                } catch {
                    guard let jiraResponseError = try? Client.jsonDecoder.decode(Jira.JiraResponseError.self,
                                                                                 from: Data(response))
                    else {
                        throw error
                    }
                    throw ClientError.jiraError(jiraResponseError)
                }
            }
        }

    }
}
