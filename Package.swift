// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BinaryCodable",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "BinaryCodable",
            targets: ["BinaryCodable"]
        )
    ],
    targets: [
        .target(
            name: "BinaryCodable"
        ),
        .testTarget(
            name: "BinaryCodableTests",
            dependencies: ["BinaryCodable"]
        )
    ]
)
