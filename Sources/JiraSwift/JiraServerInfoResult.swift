//
//  Jira.swift
//  JiraSwift
//
//  Created by Robert Feldhus on 24.09.18.
//

import Foundation
import Quack


public extension Jira {

    public class ServerInfoResult: Quack.Model {

        public static var dateFormatter: DateFormatter {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return df
        }

        public let baseUrl: String
        public let version: String
        public let versionNumbers: [Int]
        public let deploymentType: String
        public let buildNumber: Int
        public let buildDate: Date
        public let serverTime: Date
        public let scmInfo: String
        public let serverTitle: String

        public required init?(json: JSON) {
            guard let baseUrl = json["baseUrl"].string,
                let version = json["version"].string,
                let versionNumbers = json["versionNumbers"].array,
                let deploymentType = json["deploymentType"].string,
                let buildNumber = json["buildNumber"].int,
                let buildDateString = json["buildDate"].string,
                let buildDate = ServerInfoResult.dateFormatter.date(from: buildDateString),
                let serverTimeString = json["serverTime"].string,
                let serverTime = ServerInfoResult.dateFormatter.date(from: serverTimeString),
                let scmInfo = json["scmInfo"].string,
                let serverTitle = json["serverTitle"].string
            else {
                return nil
            }
            self.baseUrl = baseUrl
            self.version = version
            self.versionNumbers = versionNumbers.compactMap({ $0.int })
            self.deploymentType = deploymentType
            self.buildNumber = buildNumber
            self.buildDate = buildDate
            self.serverTime = serverTime
            self.scmInfo = scmInfo
            self.serverTitle = serverTitle
        }

    }


}
