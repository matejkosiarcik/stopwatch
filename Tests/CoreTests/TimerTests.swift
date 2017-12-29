//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class TimerTests: XCTestCase {
    private let accuracy = 0.1
}

// MARK: - Creation
extension TimerTests {
    func testInitialization() {
        // when
        let timer = Timer()

        // then
        XCTAssertEqual(timer.progress.absolute, 0)
        XCTAssertEqual(timer.progress.relative, 0)
        XCTAssertEqual(timer.state, .stopped)
    }
}

// MARK: - Running
extension TimerTests {
    func testStarting() {
        // given
        var timer = Timer()

        // when
        timer.start()
        delay(0.2)

        // then
        XCTAssertEqual(timer.progress.absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.2, accuracy: self.accuracy)
        switch timer.state {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }

    func testMultipleStarts() {
        // given
        var timer = Timer()

        // when
        timer.start()
        delay(0.2)
        timer.start()

        // then
        XCTAssertEqual(timer.progress.absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.2, accuracy: self.accuracy)
        switch timer.state {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }

    func testStopping() {
        // given
        var timer = Timer()

        // when
        timer.start()
        delay(0.2)
        timer.stop()

        // then
        XCTAssertEqual(timer.progress.absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.2, accuracy: self.accuracy)
        XCTAssertTrue(timer.state == .stopped)
    }

    func testMultipleStops() {
        // given
        var timer = Timer()

        // when
        timer.start()
        delay(0.2)
        timer.stop()
        timer.stop()

        // then
        XCTAssertEqual(timer.progress.absolute, 0.2, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.2, accuracy: self.accuracy)
        XCTAssertTrue(timer.state == .stopped)
    }

    func testToggling() {
        // given
        var timer = Timer()

        // when
        timer.toggle()
        delay(0.1)

        // then
        XCTAssertEqual(timer.progress.absolute, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.1, accuracy: self.accuracy)
        switch timer.state {
        case .running: break
        default: XCTFail("Timer should be running")
        }

        // when
        timer.toggle()

        // then
        XCTAssertEqual(timer.progress.absolute, 0.1, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.1, accuracy: self.accuracy)
        XCTAssertTrue(timer.state == .stopped)
    }
}

// MARK: - Lapping
extension TimerTests {
    func testTrivialLapping() {
        // given
        var timer = Timer()

        // when
        timer.start()
        delay(0.2)
        timer.lap()
        delay(0.1)
        timer.lap()

        // then
        XCTAssertEqual(timer.progress.absolute, 0.3, accuracy: self.accuracy)
        XCTAssertEqual(timer.progress.relative, 0.1, accuracy: self.accuracy)
        switch timer.state {
        case .running: break
        default: XCTFail("Timer should be running")
        }
    }
}
