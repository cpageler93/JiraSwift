//
//  JiraProject.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 24.10.18.
//


import Foundation
import Quack


public extension Jira {

    public class Project: Quack.Model {

        public let id: String
        public let key: String
        public let name: String

        public required init?(json: JSON) {
            guard let id = json["id"].string,
                let key = json["key"].string,
                let name = json["name"].string
            else {
                return nil
            }

            self.id = id
            self.key = key
            self.name = name
        }

    }

}
