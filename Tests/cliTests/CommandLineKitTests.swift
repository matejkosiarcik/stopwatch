//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
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
