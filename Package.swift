// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SamuraiPermissionFlow",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SamuraiPermissionFlow",
            targets: ["SamuraiPermissionFlow"]
        ),
    ],
    targets: [
        .target(
            name: "SamuraiPermissionFlow"
        ),
        .testTarget(
            name: "SamuraiPermissionFlowTests",
            dependencies: ["SamuraiPermissionFlow"]
        ),
    ]
)
