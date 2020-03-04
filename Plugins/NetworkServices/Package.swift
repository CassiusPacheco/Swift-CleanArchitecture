// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkServices",
    products: [
        .library(
            name: "NetworkServices",
            targets: ["NetworkServices"]),
    ],
    dependencies: [
    .package(path: "../../Entities")
    ],
    targets: [
        .target(
            name: "NetworkServices",
            dependencies: ["Entities"]),
        .testTarget(
            name: "NetworkServicesTests",
            dependencies: ["NetworkServices", "Entities"]),
    ]
)
