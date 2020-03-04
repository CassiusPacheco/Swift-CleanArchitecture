// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjector",
    products: [
        .library(
            name: "DependencyInjector",
            targets: ["DependencyInjector"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DependencyInjector",
            dependencies: []),
        .testTarget(
            name: "DependencyInjectorTests",
            dependencies: ["DependencyInjector"]),
    ]
)
