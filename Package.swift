// swift-tools-version:3.0

import PackageDescription

let package = Package(name: "StopWatch")

package.targets = [
    Target(name: "swatch", dependencies: ["StopWatch"]),
    Target(name: "StopWatch", dependencies: []),
]
