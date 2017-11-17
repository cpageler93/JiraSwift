//
//  JiraIssue.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 17.11.17.
//

import Foundation
import Quack
import SwiftyJSON

public class JiraIssue: QuackModel {
    
    public let id: String
    public let key: String
    public let fields: Fields
    
    public required init?(json: JSON) {
        guard
            let idString = json["id"].string,
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


extension JiraIssue {

    public class Fields: QuackModel {
        
        public let summary: String?
        
        public required init?(json: JSON) {
            self.summary = json["summary"].string
        }
        
    }

}

