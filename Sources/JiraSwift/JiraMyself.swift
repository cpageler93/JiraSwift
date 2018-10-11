//
//  JiraMyself.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.10.18.
//


import Foundation
import Quack


public extension Jira {

    public class Myself: Quack.Model {

        public let accountId: String
        public let key: String
        public let name: String
        public let emailAddress: String
        public let displayName: String
        public let active: Bool

        public let avatarUrl16: String?
        public let avatarUrl24: String?
        public let avatarUrl32: String?
        public let avatarUrl48: String?

        public required init?(json: JSON) {
            guard let accountId = json["accountId"].string,
                let key = json["key"].string,
                let name = json["name"].string,
                let emailAddress = json["emailAddress"].string,
                let displayName = json["displayName"].string,
                let active = json["active"].bool
            else {
                return nil
            }

            self.accountId = accountId
            self.key = key
            self.name = name
            self.emailAddress = emailAddress
            self.displayName = displayName
            self.active = active

            self.avatarUrl16 = json["avatarUrls"]["16x16"].string
            self.avatarUrl24 = json["avatarUrls"]["24x24"].string
            self.avatarUrl32 = json["avatarUrls"]["32x32"].string
            self.avatarUrl48 = json["avatarUrls"]["48x48"].string
        }

    }

}
