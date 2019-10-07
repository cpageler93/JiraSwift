//
//  AvatarURLs.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 30.09.19.
//


public extension Jira {

    class AvatarURLs: Codable {

        public let sixteen: String
        public let twentyFour: String
        public let thirtyTwo: String
        public let fortyEight: String

        enum CodingKeys: String, CodingKey {
            case sixteen = "16x16"
            case twentyFour = "24x24"
            case thirtyTwo = "32x32"
            case fortyEight = "48x48"
        }

    }

}
