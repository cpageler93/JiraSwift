//
//  JiraProject.swift
//  JiraSwift
//
//  Created by Christoph Pageler on 24.10.18.
//


public struct Project: Codable {

    public var id: String
    public var key: String
    public var name: String
    public var projectTypeKey: String
    public var avatarUrls: AvatarURLs

}

public struct ProjectType: Codable {

    public var key: String
    public var formattedKey: String
    public var descriptionI18nKey: String
    public var icon: String
    public var color: String
}
