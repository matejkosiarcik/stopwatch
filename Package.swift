// swift-tools-version:4.0

import PackageDescription

let package = Package(name: "StopWatch")

package.dependencies = [
    .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0")
]

package.products = [
   .executable(name: "swatch", targets: ["main"]),
   .library(name: "StopWatch", targets: ["lib"]),
]

package.targets = [
    // executable
    .target(name: "main", dependencies: ["cli"]),

    // cli interface for testing
    .target(name: "cli", dependencies: ["lib"]),
    .testTarget(name: "cliTests", dependencies: ["cli", "Nimble"]),

    // library
    .target(name: "lib", dependencies: []),
    .testTarget(name: "libTests", dependencies: ["lib", "Nimble"]),
]
