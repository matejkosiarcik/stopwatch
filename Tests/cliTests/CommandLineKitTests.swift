//
// CommandLineKitTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import CommandLineKit
import XCTest

final class CommandLineKitTests: XCTestCase {}

extension CommandLineKitTests {
    func testUsage() {
        // given
        let parser = CommandLineKit.CommandLine()
        parser.addOption(BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Help message"))
        try? parser.parse()
        var expected = ""
        parser.printUsage(&expected)

        // when
        let tested = parser.usage

        // then
        XCTAssertEqual(tested, expected)
    }
}
