//
//  JiraSwiftCLI.swift
//  JiraSwiftCLI
//
//  Created by Christoph Pageler on 11.04.18.
//


import Commander
import Foundation
import Quack


public class JiraSwiftCLI {
    
    internal static let noDefaultValue: String = "NO DEFAULT VALUE"
    
    internal let urlOption = Option("url",
                                    default: JiraSwiftCLI.noDefaultValue,
                                    flag: nil,
                                    description: "Jira URL",
                                    validator: nil)
    internal let urlEnvKey: String = "JIRA_URL"
    
    
    internal let usernameOption = Option("username",
                                         default: JiraSwiftCLI.noDefaultValue,
                                         flag: Character("u"),
                                         description: "Jira Username",
                                         validator: nil)
    internal let usernameEnvKey: String = "JIRA_USERNAME"
    
    
    internal let passwordOption = Option("password",
                                         default: JiraSwiftCLI.noDefaultValue,
                                         flag: Character("p"),
                                         description: "Jira Password",
                                         validator: nil)
    internal let passwordEnvKey: String = "JIRA_PASSWORD"
    
    
    internal let jqlArgument = Argument<String>("jql",
                                                description: "JQL Query")
    
    public func run() {
        
        Group {
            search(group: $0)
        }.run()
    }
    
    internal func secure(_ closure: () throws -> ()) {
        do {
            try closure()
        } catch let error {
            print("Error: \(error.localizedDescription)")
            exit(1)
        }
        
        exit(0)
    }
    
}

internal extension JiraSwiftCLI {
    
    enum Error: Swift.Error {
        case noEnvWith(key: String)
        case notAValidURL(string: String)
        case quackError(error: Quack.Error)
    }
    
}

extension JiraSwiftCLI.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noEnvWith(let key): return "No Environment Variable with key `\(key)`"
        case .notAValidURL(let string): return "Not a valid url `\(string)`"
        case .quackError(let error): return "\(error)"
        default: return "Unknown Error"
        }
    }
    
}

internal extension String {
    
    func isNoDefaultValue() -> Bool {
        return self == JiraSwiftCLI.noDefaultValue
    }
    
    mutating func loadFromEnv(_ key: String) throws {
        guard let valueFromEnv = ProcessInfo.processInfo.environment[key] else {
            throw JiraSwiftCLI.Error.noEnvWith(key: key)
        }
        self = valueFromEnv
    }
    
    mutating func ensureWithEnv(_ key: String) throws {
        if isNoDefaultValue() {
            try loadFromEnv(key)
        }
    }
    
}
