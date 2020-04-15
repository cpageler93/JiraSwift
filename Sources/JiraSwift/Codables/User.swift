//
//  JiraUser.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 11.10.18.
//


public class User: Codable {

    public var accountId: String?
    public var key: String?
    public var name: String?
    public var emailAddress: String?
    public var displayName: String
    public var active: Bool
    public var timeZone: String
    public var avatarUrls: AvatarURLs

}
