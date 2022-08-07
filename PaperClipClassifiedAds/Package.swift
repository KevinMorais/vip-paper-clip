// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaperClipClassifiedAds",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PaperClipClassifiedAds",
            targets: ["PaperClipClassifiedAds"])
    ],
    dependencies: [
        .package(name: "PaperClipNetworkCore", path: "../PaperClipNetworkCore"),
        .package(name: "PaperClipCore", path: "../PaperClipCore"),
        .package(name: "PaperClipCategories", path: "../PaperClipCategories")
    ],
    targets: [
        .target(
            name: "PaperClipClassifiedAds",
            dependencies: [
                "PaperClipNetworkCore",
                "PaperClipCore",
                "PaperClipCategories"
            ]),
        .testTarget(
            name: "PaperClipClassifiedAdsTests",
            dependencies: ["PaperClipClassifiedAds"])
    ]
)
