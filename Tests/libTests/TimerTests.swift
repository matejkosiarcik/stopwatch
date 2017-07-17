//
// TimerTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import XCTest

final class TimerTest: XCTestCase {}

extension TimerTest {
    func testInitialization() {
        // when
        let timer = lib.Timer()

        // then
        XCTAssertEqual(timer.current, 0)
        XCTAssertEqual(timer.laps, [])
        XCTAssertEqual(timer.status, .stopped)
    }

    func testStarting() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()

        // then
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { exp.fulfill() }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(timer.current, 0.3, accuracy: 0.015)
        switch timer.status {
        case .running: break
        default: XCTFail()
        }
    }
}
