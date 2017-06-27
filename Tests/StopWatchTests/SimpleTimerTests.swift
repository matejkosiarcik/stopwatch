//
// SimpleTimerTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class SimpleTimerTest: XCTestCase {}

extension SimpleTimerTest {
    func testStarting() {
        // given
        var collector = [TimeInterval]()
        let timer = SimpleTimer(each: 0.1) { collector.append($0) }

        // when
        expect(collector.isEmpty) == true
        timer.start()

        // then
        expect(collector.isEmpty).toEventually(beFalse())
    }

    func testUpdating() {
        // given
        var collector = [TimeInterval]()
        let timer = SimpleTimer(each: 0.1) { collector.append($0) }

        // when
        timer.start()
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) { exp.fulfill() }
        wait(for: [exp], timeout: 0.45)

        // then
        expect(collector.count) == 5
    }

    func testStopping() {
        // given
        var collector = [TimeInterval]()
        let timer = SimpleTimer(each: 0.1, onUpdate: { collector.append($0) })

        // when
        timer.start()
        let onStopExpectation = expectation(description: "")
        var onStop = [TimeInterval]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onStop = collector
            timer.stop()
            onStopExpectation.fulfill()
        }
        wait(for: [onStopExpectation], timeout: 1.1)

        // then
        let afterStopExpectation = expectation(description: "")
        var afterStop = [TimeInterval]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { afterStop = collector; afterStopExpectation.fulfill() }
        wait(for: [afterStopExpectation], timeout: 1.1)
        expect(collector.isEmpty) == false
        expect(onStop) == afterStop
    }
}
