//
// TimerStatusTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import XCTest

final class TimerStatusTest: XCTestCase {}

// MARK: - Equality
extension TimerStatusTest {
    func testEquality() {
        // given
        let date = Date()
        let reference: [lib.Timer.Status] = [.stopped, .running(date)]
        let testers: [lib.Timer.Status] = [.stopped, .running(date), .running(Date())]
        let expected = [[true, false, false], [false, true, false]].flatMap { $0 }

        // when
        let tested = reference.flatMap { ref in testers.flatMap { ref == $0 } }

        // then
        XCTAssertEqual(tested, expected)
    }
}
