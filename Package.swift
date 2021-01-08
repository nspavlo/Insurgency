// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Insurgency",
    products: [
        .library(name: "Insurgency", targets: ["Insurgency"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.35.8"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.28.1"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Insurgency", dependencies: [], path: "Insurgency"),
        .testTarget(name: "InsurgencyTests", dependencies: ["Insurgency"], path: "InsurgencyTests"),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": [
                "swift run swiftformat .",
                "swift run swiftlint --path Insurgency/",
            ],
        ],
        "rocket": [
            "after": [
                "push",
            ],
        ],
    ]).write()
#endif
