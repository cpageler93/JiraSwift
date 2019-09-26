//
//  JiraSwiftCLISearch.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 11.04.18.
//

import JiraSwift
import Commander
import Foundation


internal extension JiraSwiftCLI {
    
    func search(group: Group) {
        group.command(
            "search",
            urlOption,
            usernameOption,
            passwordOption,
            jqlArgument
        ) { (jiraURL: String, username: String, password: String, jql: String) in
            self.secure {
                var jiraURL = jiraURL
                try jiraURL.ensureWithEnv(self.urlEnvKey)
                
                guard let url = URL(string: jiraURL) else {
                    throw Error.notAValidURL(string: jiraURL)
                }
                
                var username = username
                try username.ensureWithEnv(self.usernameEnvKey)
                
                var password = password
                try password.ensureWithEnv(self.passwordEnvKey, allowUserInput: true, secure: true)

                let client = Jira.Client(baseURL: url.absoluteString, username: username, password: password)
                let result = try client.search(jql: jql).wait()

                print("result: \(result.total)")
            }
        }
    }
    
}
