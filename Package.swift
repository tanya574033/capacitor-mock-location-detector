// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorMockLocationDetectorPlugin",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorMockLocationDetectorPlugin",
            targets: ["CapacitorMockLocationDetectorPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapacitorMockLocationDetectorPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorMockLocationDetectorPlugin"),
        .testTarget(
            name: "CapacitorMockLocationDetectorPluginTests",
            dependencies: ["CapacitorMockLocationDetectorPlugin"],
            path: "ios/Tests/CapacitorMockLocationDetectorPluginTests")
    ]
)