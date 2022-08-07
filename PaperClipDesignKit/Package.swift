// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaperClipDesignKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PaperClipDesignKit",
            targets: ["PaperClipDesignKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PaperClipDesignKit",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "PaperClipDesignKitTests",
            dependencies: ["PaperClipDesignKit"])
    ]
)
