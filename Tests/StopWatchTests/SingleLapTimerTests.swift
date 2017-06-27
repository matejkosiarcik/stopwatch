//
// SingleLapTimerTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class SingleLapTimerTest: XCTestCase {}

extension SingleLapTimerTest {
    func testStarting() {
        // given
        var collector = [TimeInterval]()
        let watcher = SingleLapTimer(each: 0.1) { collector.append($0) }

        // when
        expect(collector.isEmpty) == true
        watcher.start()

        // then
        expect(collector.isEmpty).toEventually(beFalse())
    }

    func testUpdating() {
        // given
        var collector = [TimeInterval]()
        let watcher = SingleLapTimer(each: 0.1) { collector.append($0) }

        // when
        watcher.start()
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) { exp.fulfill() }
        wait(for: [exp], timeout: 0.45)

        // then
        expect(collector.count) == 5
    }

    func testStopping() {
        // given
        var collector = [TimeInterval]()
        let watcher = SingleLapTimer(each: 0.1, onUpdate: { collector.append($0) })

        // when
        watcher.start()
        let onStopExpectation = expectation(description: "")
        var onStop = [TimeInterval]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onStop = collector
            watcher.stop()
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
