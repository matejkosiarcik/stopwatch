//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import XCTest

final class DelayTests: XCTestCase {}

extension DelayTests {
    func testDelay() {
        // given
        let start = Date()

        // when
        delay(0.5)
        let interval = abs(start.timeIntervalSinceNow)

        // then
        XCTAssertEqual(interval, 0.5, accuracy: 0.05)
    }
}
