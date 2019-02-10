// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "e16erver",
    products: [
      .executable(name: "e16server",
                  targets: [
                    "Service",
                    "EchoService",
                    "Server",
                  ]
      ),
      .library(name: "Service", targets: ["Service"]),
      .library(name: "EchoService", targets: ["EchoService", "Service"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CSCIX65G/smoke-framework.git", .branch("swift5")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Server",
            dependencies: ["Service", "EchoService", "HeliumLogger"]),
        .target(
            name: "EchoService",
            dependencies: ["Service", "SmokeOperations", "SmokeHTTP1", "SmokeOperationsHTTP1"]),
        .target(
            name: "Service",
            dependencies: ["SmokeOperations", "SmokeHTTP1", "SmokeOperationsHTTP1"]),
        .testTarget(
            name: "ServerTests",
            dependencies: ["Server"]),
    ]
)
