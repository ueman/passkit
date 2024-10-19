// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "apple_passkit",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "apple-passkit", targets: ["apple_passkit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "apple_passkit",
            dependencies: [],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)