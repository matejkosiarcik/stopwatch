// swift-tools-version:4.0

import PackageDescription

let package = Package(name: "StopWatch")

package.products = [
   .executable(name: "swatch", targets: ["main"]),
   .library(name: "StopWatch", targets: ["lib"]),
]

package.targets = [
    // executable
    .target(name: "main", dependencies: ["cli"]),

    // cli interface for testing
    // This target exists because main/executable targets are not testable
    .target(name: "cli", dependencies: ["lib"]),
    .testTarget(name: "cliTests", dependencies: ["cli"]),

    // library
    .target(name: "lib", dependencies: []),
    .testTarget(name: "libTests", dependencies: ["lib"]),
]
