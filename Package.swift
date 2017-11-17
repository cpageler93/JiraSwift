// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiraSwift",
    products: [
        .library(name: "JiraSwift", targets: ["JiraSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cpageler93/Quack", from: "1.0.2"),
    ],
    targets: [
        .target(name: "JiraSwift", dependencies: ["Quack"]),
        .testTarget(name: "JiraSwiftTests", dependencies: ["JiraSwift"]),
    ]
)
