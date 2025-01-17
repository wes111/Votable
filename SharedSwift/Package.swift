// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// This package is for core shared Swift code.
// It should have no dependencies!
// It should not have any UI code either.
let package = Package(
    name: "SharedSwift",
    platforms: [
        .iOS("18.0") // Minimum iOS version is set to 18.0
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedSwift",
            targets: ["SharedSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SharedSwift"),
        .testTarget(
            name: "SharedSwiftTests",
            dependencies: ["SharedSwift"]
        ),
    ]
)
