//
// TimerTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import lib
import XCTest

final class TimerTests: XCTestCase {
    private let accuracy = 0.013
}

// MARK: - Cretion
extension TimerTests {
    func testInitialization() {
        // when
        let timer = lib.Timer()

        // then
        XCTAssertEqual(timer.current, 0)
        XCTAssertEqual(timer.laps, [])
        XCTAssertEqual(timer.status, .stopped)
    }
}

// MARK: - Running
extension TimerTests {
    func testStarting() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)

        // then
        XCTAssertEqual(timer.current, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps, [])
        switch timer.status {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }

    func testMultipleStarts() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)
        timer.start()

        // then
        XCTAssertEqual(timer.current, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps, [])
        switch timer.status {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }

    func testStopping() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)
        timer.stop()

        // then
        XCTAssertEqual(timer.current, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps, [])
        switch timer.status {
        case .stopped: break
        default: XCTFail("Timer should be stopped")
        }
    }

    func testMultipleStops() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)
        timer.stop()
        timer.stop()

        // then
        XCTAssertEqual(timer.current, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps, [])
        switch timer.status {
        case .stopped: break
        default: XCTFail("Timer should be stopped")
        }
    }
}

// MARK: - Lapping
extension TimerTests {
    func testStationaryLaps() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)
        timer.stop()
        timer.lap()
        timer.lap()
        timer.lap()

        // then
        XCTAssertEqual(timer.laps.count, 3)
        XCTAssertEqual(timer.laps[0].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].relative, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].absolute, timer.laps[0].relative)
        XCTAssertEqual(timer.laps[1].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[1].relative, 0, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[1].absolute, timer.laps[0].absolute)
        XCTAssertEqual(timer.laps[2].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[2].relative, 0, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[2].absolute, timer.laps[1].absolute)
        XCTAssertEqual(timer.current, 0.2, accuracy: self.accuracy)
        switch timer.status {
        case .stopped: break
        default: XCTFail("Timer should be stopped")
        }
    }

    func testTrivialLapping() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.2)
        timer.lap()
        delay(0.1)
        timer.lap()

        // then
        XCTAssertEqual(timer.laps.count, 2)
        XCTAssertEqual(timer.laps[0].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].relative, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].absolute, timer.laps[0].relative)
        XCTAssertEqual(timer.laps[1].absolute, 0.3, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[1].relative, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.current, 0.3, accuracy: 0.01)
        switch timer.status {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }

    func testComplicatedLapping() {
        // given
        var timer = lib.Timer()

        // when
        timer.start()
        delay(0.1)
        timer.lap()
        timer.stop()

        // then
        XCTAssertEqual(timer.laps.count, 1)
        XCTAssertEqual(timer.laps[0].absolute, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].relative, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].absolute, timer.laps[0].relative)
        switch timer.status {
        case .stopped: break
        default: XCTFail("Timer should be stopped")
        }

        // when
        timer.start()
        delay(0.1)
        timer.lap()
        timer.stop()
        timer.lap()
        timer.lap()

        // then
        XCTAssertEqual(timer.laps.count, 4)
        XCTAssertEqual(timer.laps[0].absolute, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].relative, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[0].absolute, timer.laps[0].relative)
        XCTAssertEqual(timer.laps[1].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[1].relative, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[2].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[2].relative, 0, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[3].absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[3].relative, 0, accuracy: self.accuracy)
        XCTAssertEqual(timer.laps[3].absolute, timer.laps[2].absolute)
        switch timer.status {
        case .stopped: break
        default: XCTFail("Timer should be stopped")
        }
    }
}
