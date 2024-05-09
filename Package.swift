// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "NagasakiSC",
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.54.0") // Adjust SwiftLint version as needed
    ],
    targets: [
        .target(
            name: "NagasakiSC",
            dependencies: ["SwiftLint"]),
        // ... your other targets
    ]
)
