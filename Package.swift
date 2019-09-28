// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiraSwift",
    products: [
        .library(name: "JiraSwift", targets: ["JiraSwift"]),
        .executable(name: "jira", targets: ["JiraSwiftCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.0.0-alpha.4"),
        .package(url: "https://github.com/vapor/console-kit", from: "4.0.0-alpha.2.1"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.9.0")
    ],
    targets: [
        .target(name: "JiraSwift", dependencies: ["AsyncHTTPClient"]),
        .target(name: "JiraSwiftCLI", dependencies: ["JiraSwift", "ConsoleKit", "SwiftyTextTable"]),
        .testTarget(name: "JiraSwiftTests", dependencies: ["JiraSwift"])
    ]
)
