// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Entities")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Entities"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Entities"]),
    ]
)
