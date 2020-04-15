//
//  AvatarURLs.swift
//  AsyncHTTPClient
//
//  Created by Christoph Pageler on 30.09.19.
//


public struct AvatarURLs: Codable {

    enum CodingKeys: String, CodingKey {
        case sixteen = "16x16"
        case twentyFour = "24x24"
        case thirtyTwo = "32x32"
        case fortyEight = "48x48"
    }

    public var sixteen: String
    public var twentyFour: String
    public var thirtyTwo: String
    public var fortyEight: String

}
