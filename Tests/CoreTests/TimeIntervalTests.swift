//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class TimeIntervalTests: XCTestCase {}

extension TimeIntervalTests {
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
