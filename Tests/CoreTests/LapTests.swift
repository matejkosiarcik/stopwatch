//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class LapTests: XCTestCase {}

// MARK: - Creation
extension LapTests {
    func testInitialization() {
        // given
        let times: (TimeInterval, TimeInterval) = (15, 0.46)

        // when
        let lap = Timer.Interval(absolute: times.0, relative: times.1)

        // then
        XCTAssertEqual(lap.absolute, times.0)
        XCTAssertEqual(lap.relative, times.1)
    }
}

// MARK: - Equality
extension LapTests {
    func testEquality() {
        // given
        let items = [
            (10, 5),
            (10, 5.1),
            (10, 4.9),
            (3, 5),
            (100, 100),
            ].map { Timer.Interval(absolute: $0.0, relative: $0.1) }
        let comparator = items[0]
        let expected = [true] + [Bool](repeating: false, count: 4)

        // when
        let equalities = items.map { $0 == comparator }

        // then
        XCTAssertEqual(equalities, expected)
    }
}

// MARK: - Formatting
extension LapTests {
    func testFormattingSingleItem() {
        // given
        let laps = [
            (5, 4),
            (1.5, 1.5),
            (1.5, 2.075),
            ].map { Timer.Interval(absolute: $0.0, relative: $0.1) }
        let expected = [
            "00:00:05.000 : 00:00:04.000",
            "00:00:01.500 : 00:00:01.500",
            "00:00:01.500 : 00:00:02.075",
            ]

        // when
        let formatted = laps.map { $0.formatted }

        // then
        XCTAssertEqual(formatted, expected)
    }
}
