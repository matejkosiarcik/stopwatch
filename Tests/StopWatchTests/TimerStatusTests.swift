//
// TimerStatusTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class TimerStatusTest: XCTestCase {}

extension TimerStatusTest {
    func testEquatability() {
        // given
        let date = Date()
        let reference: [StopWatch.Timer.Status] = [.stopped, .running(date)]
        let testers: [StopWatch.Timer.Status] = [.stopped, .running(date), .running(Date())]
        let expected = [[true, false, false], [false, true, false]].flatMap { $0 }

        // when
        let tested = reference.flatMap { ref in testers.flatMap { ref == $0 } }

        // then
        expect(tested) == expected
    }
}
