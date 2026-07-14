// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FocusNotch",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "FocusNotch", targets: ["FocusNotch"])
    ],
    targets: [
        .executableTarget(
            name: "FocusNotch"
        )
    ]
)
