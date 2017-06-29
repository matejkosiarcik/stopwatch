//
// TimerTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import Nimble
import XCTest

final class TimerTest: XCTestCase {}

extension TimerTest {
    func testInitialization() {
        // when
        let timer = lib.Timer()

        // then
        expect(timer.current) == 0
        expect(timer.laps) == []
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
        expect(timer.current).to(beCloseTo(0.3, within: 0.01))
        switch timer.status {
        case .running: break
        default: XCTFail()
        }
    }
}
