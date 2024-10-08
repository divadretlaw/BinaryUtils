// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BinaryUtils",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "BinaryUtils",
            targets: ["BinaryUtils"]
        )
    ],
    targets: [
        .target(
            name: "BinaryUtils"
        ),
        .testTarget(
            name: "BinaryUtilTests",
            dependencies: ["BinaryUtils"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
