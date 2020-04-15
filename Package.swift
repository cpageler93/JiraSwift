// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jira-swift",
    platforms: [
       .macOS(.v10_15),
       .iOS(.v10),
       .tvOS(.v13)
    ],
    products: [
        .library(name: "JiraSwift", targets: ["JiraSwift"]),
        .executable(name: "jira", targets: ["JiraSwiftCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/cpageler93/api-client.git", from: "0.2.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.9.0")
    ],
    targets: [
        .target(name: "JiraSwift", dependencies: [
            .product(name: "APIClient", package: "api-client")
        ]),
        .target(name: "JiraSwiftCLI", dependencies: [
            .target(name: "JiraSwift"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "SwiftyTextTable", package: "SwiftyTextTable"),
        ]),
        .testTarget(name: "JiraSwiftTests", dependencies: ["JiraSwift"])
    ]
)
