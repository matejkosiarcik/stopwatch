//
// TimeIntervalTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import XCTest

final class TimeIntervalTest: XCTestCase {}

extension TimeIntervalTest {
    func testFormatting() {
        // given
        let intervals = [0, 1.345_039_28, 345.999_9, 4_573.68]
        let expected = [
            "00:00:00.000",
            "00:00:01.345",
            "00:05:45.999",
            "01:16:13.680",
        ]

        // when
        let formatted = intervals.map { $0.formatted }

        // then
        XCTAssertEqual(formatted, expected)
    }
}
