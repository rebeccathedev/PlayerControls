// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlayerControls",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "PlayerControls",
            targets: ["PlayerControls"]),
    ],
    targets: [
        .target(
            name: "PlayerControls",
            dependencies: [],
            path: "PlayerControls",
            exclude: [
                "Info.plist",
                "PlayerControls.h"
            ],
            linkerSettings: [
                .linkedFramework("AppKit")
            ]
        ),
        .testTarget(
            name: "PlayerControlsTests",
            dependencies: ["PlayerControls"],
            path: "PlayerControlsTests"
        ),
    ]
)
