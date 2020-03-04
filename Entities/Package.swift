// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Entities",
    products: [
        .library(
            name: "Entities",
            targets: ["Entities"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Entities",
            dependencies: []),
        .testTarget(
            name: "EntitiesTests",
            dependencies: ["Entities"]),
    ]
)
