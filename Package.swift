// swift-tools-version:4.0
import PackageDescription

let package = Package(name: "Stopwatch")

package.dependencies = [
    .package(url: "https://github.com/rxwei/CommandLine.git", from: "3.0.0"),
    .package(url: "https://github.com/antitypical/Result.git", from: "3.0.0"),
]

package.products = [
    .executable(name: "swatch", targets: ["main"]),
]

package.targets = [
    // executable
    .target(name: "main", dependencies: ["Core", "Result"]),

    // library
    .target(name: "Core", dependencies: ["CommandLine", "Result"]),
    .testTarget(name: "CoreTests", dependencies: ["Core"]),
]
