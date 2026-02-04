// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Lox",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(name: "Lox", targets: ["Lox"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.4")
    ],
    targets: [
        .target(
            name: "Lox",
            dependencies: [.product(name: "Logging", package: "swift-log")]
        ),
        .testTarget(
            name: "LoxTests",
            dependencies: ["Lox"]
        )
    ]
)
