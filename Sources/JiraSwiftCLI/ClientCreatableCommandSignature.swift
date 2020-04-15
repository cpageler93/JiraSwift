//
//  ClientCreatableCommandSignature.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 30.09.19.
//


//import Foundation
//import ConsoleKit
//import JiraSwift
//
//
//protocol ClientCreatableCommandSignature {
//
//    var url: String? { get }
//    var username: String? { get }
//    var password: String? { get }
//
//    func client() -> Jira.Client?
//
//}
//
//extension ClientCreatableCommandSignature {
//
//    func client() -> Jira.Client? {
//        let env = ProcessInfo.processInfo.environment
//        guard let url = url ?? env["JIRA_URL"],
//            let username = username ?? env["JIRA_USERNAME"],
//            let password = password ?? env["JIRA_PASSWORD"]
//        else {
//            return nil
//        }
//        return Jira.Client(baseURL: url, username: username, password: password)
//    }
//}
