//
// WatcherTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class WatcherTest: XCTestCase {}

extension WatcherTest {
    func testStarting() {
        // given
        var collector = [Interval]()
        let watcher = Watcher(each: 0.1) { collector.append($0) }

        // when
        expect(collector.isEmpty) == true
        watcher.start()

        // then
        expect(collector.isEmpty).toEventually(beFalse())
    }

    func testUpdating() {
        // given
        var collector = [Interval]()
        let watcher = Watcher(each: 0.1) { collector.append($0) }

        // when
        watcher.start()
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) { exp.fulfill() }
        wait(for: [exp], timeout: 0.45)

        // then
        expect(collector.count) == 4
    }

    func testStopping() {
        // given
        var collector = [Interval]()
        let watcher = Watcher(each: 0.1, onUpdate: { collector.append($0) })

        // when
        watcher.start()
        let onStopExpectation = expectation(description: "")
        var onStop = [Interval]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onStop = collector
            watcher.stop()
            onStopExpectation.fulfill()
        }
        wait(for: [onStopExpectation], timeout: 1.1)

        // then
        let afterStopExpectation = expectation(description: "")
        var afterStop = [Interval]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { afterStop = collector; afterStopExpectation.fulfill() }
        wait(for: [afterStopExpectation], timeout: 1.1)
        expect(collector.isEmpty) == false
        expect(onStop) == afterStop
    }
}
