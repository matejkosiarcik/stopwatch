// swift-tools-version:4.0

import PackageDescription

let package = Package(name: "StopWatch")

package.dependencies = [
    .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0")
]

package.targets = [
    .target(name: "swatch", dependencies: ["StopWatch"]), // executable
    .target(name: "StopWatch", dependencies: []), // library
    .testTarget(name: "StopWatchTests", dependencies: ["StopWatch", "Nimble"]),
]
