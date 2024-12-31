// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DemocracySwiftUI",
    platforms: [
        .iOS("18.0") // Minimum iOS version is set to 18.0
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DemocracySwiftUI",
            targets: ["DemocracySwiftUI"]),
    ],
    dependencies: [
        // Declare local package dependencies
        .package(name: "SharedResourcesClientAndServer", path: "Democracy/SharedResourcesClientAndServer"),
        .package(name: "SharedSwiftUI", path: "Democracy/SharedSwiftUI")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        .target(
            name: "DemocracySwiftUI",
            dependencies: [
                "SharedResourcesClientAndServer", // Add the dependency to this target
                "SharedSwiftUI"                   // Add the new dependency to this target
            ]
        ),
        .testTarget(
            name: "DemocracySwiftUITests",
            dependencies: ["DemocracySwiftUI"]
        ),
    ]
)
