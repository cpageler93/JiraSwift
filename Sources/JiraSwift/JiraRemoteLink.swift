//
//  JiraRemoteLink.swift
//  JiraSwiftPackageDescription
//
//  Created by Christoph Pageler on 19.02.18.
//

import Foundation
import Quack
import SwiftyJSON


public class JiraRemoteLink: QuackModel {
    
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
