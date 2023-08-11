// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GRFKit",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "GRFKit",
            targets: ["GRFKit"]),
    ],
    targets: [
        .target(
            name: "GRFKit"),
        .testTarget(
            name: "GRFKitTests",
            dependencies: ["GRFKit"],
            resources: [.copy("Assets")]),
    ]
)
