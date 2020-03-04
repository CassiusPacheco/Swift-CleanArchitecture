// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(path: "../Entities"),
        .package(path: "../Data")
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: ["Entities", "Data"]),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "Entities", "Data"]),
    ]
)
