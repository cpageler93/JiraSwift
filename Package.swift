// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiraSwift",
    products: [
        .library(name: "JiraSwift", targets: ["JiraSwift"]),
        .executable(name: "JiraSwiftCLI", targets: ["JiraSwiftCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.0.0-alpha.4"),
        .package(url: "https://github.com/kylef/Commander", from: "0.8.0")
    ],
    targets: [
        .target(name: "JiraSwift", dependencies: ["AsyncHTTPClient"]),
        .target(name: "JiraSwiftCLI", dependencies: ["JiraSwift", "Commander"]),
        .testTarget(name: "JiraSwiftTests", dependencies: ["JiraSwift"])
    ]
)
