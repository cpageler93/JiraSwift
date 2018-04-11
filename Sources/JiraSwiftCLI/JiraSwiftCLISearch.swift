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
                try password.ensureWithEnv(self.passwordEnvKey)
                
                let client = Jira.Client(url: url, username: username, password: password)
                let result = client.search(jql: jql)
                
                switch result {
                case .success(let result):
                    print("result: \(result.total)")
                case .failure(let error):
                    throw error
                }
            }
        }
    }
    
}
