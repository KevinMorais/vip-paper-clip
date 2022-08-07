// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaperClipNetworkCore",
    products: [
        .library(
            name: "PaperClipNetworkCore",
            targets: ["PaperClipNetworkCore"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PaperClipNetworkCore",
            dependencies: []),
        .testTarget(
            name: "PaperClipNetworkCoreTests",
            dependencies: ["PaperClipNetworkCore"])
    ]
)
