//
//  JiraIssue.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//


import Foundation
import Quack


public extension Jira {

    public class Issue: Quack.Model {

        public let id: String
        public let key: String
        public let fields: Fields

        public required init?(json: JSON) {
            guard let idString = json["id"].string,
                let keyString = json["key"].string,
                let fields = Fields(json: json["fields"])
            else {
                return nil
            }

            self.id = idString
            self.key = keyString
            self.fields = fields
        }

    }

}


extension Jira.Issue {

    public class Fields: Quack.Model {

        public let summary: String?
        public let project: Jira.Project
        public let components: [Jira.Issue.Component]

        public required init?(json: JSON) {
            guard let project = Jira.Project(json: json["project"]) else { return nil }
            self.summary = json["summary"].string
            self.project = project
            self.components = json["components"].array?.compactMap { Component(json: $0) } ?? []
        }

    }

}


extension Jira.Issue {

    public class Component: Quack.Model {

        public let id: String
        public let name: String
        public let selfURL: String

        public required init?(json: JSON) {
            guard let idString = json.dictionary?["id"]?.string,
                let nameString = json.dictionary?["name"]?.string,
                let selfURL = json.dictionary?["self"]?.string
            else {
                return nil
            }

            self.id = idString
            self.name = nameString
            self.selfURL = selfURL
        }

    }

}
