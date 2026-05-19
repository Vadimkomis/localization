// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Localization",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Localization",
            targets: ["Localization"]
        )
    ],
    targets: [
        .target(name: "Localization"),
        .testTarget(
            name: "LocalizationTests",
            dependencies: ["Localization"]
        )
    ]
)
