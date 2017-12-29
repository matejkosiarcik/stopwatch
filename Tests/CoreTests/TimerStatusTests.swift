//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class TimerStatusTests: XCTestCase {}

// MARK: - Equality
extension TimerStatusTests {
    func testEquality() {
        // given
        let date = Date()
        let reference: [Core.Timer.State] = [.stopped, .running(date)]
        let testers: [Core.Timer.State] = [.stopped, .running(date), .running(Date())]
        let expected = [[true, false, false], [false, true, false]].flatMap { $0 }

        // when
        let tested = reference.flatMap { ref in testers.flatMap { ref == $0 } }

        // then
        XCTAssertEqual(tested, expected)
    }
}
