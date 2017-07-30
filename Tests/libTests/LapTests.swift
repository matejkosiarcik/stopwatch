//
// LapTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import XCTest

final class LapTest: XCTestCase {}

// MARK: - Creation
extension LapTest {
    func testInitialization() {
        // given
        let times: (TimeInterval, TimeInterval) = (15, 0.46)

        // when
        let lap = Timer.Lap(absolute: times.0, relative: times.1)

        // then
        XCTAssertEqual(lap.absolute, times.0)
        XCTAssertEqual(lap.relative, times.1)
    }
}

// MARK: - Equality
extension LapTest {
    func testEquality() {
        // given
        let items = [
            (10, 5),
            (10, 5.1),
            (10, 4.9),
            (3, 5),
            (100, 100),
            ].map { Timer.Lap(absolute: $0.0, relative: $0.1) }
        let comparator = items[0]
        let expected = [true] + [Bool](repeating: false, count: 4)

        // when
        let equalities = items.map { $0 == comparator }

        // then
        XCTAssertEqual(equalities, expected)
    }
}
