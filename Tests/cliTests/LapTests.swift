//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import lib
import XCTest

final class LapTests: XCTestCase {}

// MARK: - Formatting
extension LapTests {
    func testFormattingSingleItem() {
        // given
        let laps = [
            (5, 4),
            (1.5, 1.5),
            (1.5, 2.075),
            ].map { Timer.Lap(absolute: $0.0, relative: $0.1) }
        let expected = [
            "00:00:05.000 : 00:00:04.000",
            "00:00:01.500 : -",
            "00:00:01.500 : 00:00:02.075",
            ]

        // when
        let formatted = laps.map { $0.formatted }

        // then
        XCTAssertEqual(formatted, expected)
    }

    func testFormattingMultipleItems() {
        // given
        let laps = [
            (1, 1),
            (1.5, 0.5),
            (2.75, 1.25),
            ].map { Timer.Lap(absolute: $0.0, relative: $0.1) }
        let expected = """
            00:00:01.000 : -
            00:00:01.500 : 00:00:00.500
            00:00:02.750 : 00:00:01.250
            """

        // when
        let formatted = laps.formatted

        // then
        XCTAssertEqual(formatted, expected)
    }
}
