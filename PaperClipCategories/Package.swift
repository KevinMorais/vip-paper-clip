// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaperClipCategories",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PaperClipCategories",
            targets: ["PaperClipCategories"])
    ],
    dependencies: [
        .package(name: "PaperClipNetworkCore", path: "../PaperClipNetworkCore"),
        .package(name: "PaperClipCore", path: "../PaperClipCore")
    ],
    targets: [
        .target(
            name: "PaperClipCategories",
            dependencies: [
                "PaperClipNetworkCore",
                "PaperClipCore"
            ]
        ),
        .testTarget(
            name: "PaperClipCategoriesTests",
            dependencies: ["PaperClipCategories"])
    ]
)
