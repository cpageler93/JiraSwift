//
//  JiraRemoteLink.swift
//  JiraSwiftPackageDescription
//
//  Created by Christoph Pageler on 19.02.18.
//

import Foundation
import Quack


public extension Jira {
    
    public class RemoteLink: Quack.Model {
        
        let id: Int
        let selfUrl: String
        
        required public init?(json: JSON) {
            guard let id = json["id"].int,
                let selfUrl = json["self"].string
            else {
                return nil
            }
            
            self.id = id
            self.selfUrl = selfUrl
        }
        
    }

    
}
