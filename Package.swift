// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Rista",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "Rista", targets: ["RistaMac"]),
        .library(name: "RistaCore", targets: ["RistaCore"])
    ],
    targets: [
        .target(
            name: "RistaCore"
        ),
        .executableTarget(
            name: "RistaMac",
            dependencies: ["RistaCore"]
        ),
        .testTarget(
            name: "RistaCoreTests",
            dependencies: ["RistaCore"]
        )
    ]
)
