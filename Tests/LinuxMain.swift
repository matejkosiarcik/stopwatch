// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import CoreTests
import XCTest

extension ArgumentsTests {
    static var allTests = [
        ("testInitialization", testInitialization),
        ("testUnsuccessfulParsing", testUnsuccessfulParsing),
        ("testSuccessfulParsing", testSuccessfulParsing),
        ("testErrorDescription", testErrorDescription),
    ]
}

extension CommandLineKitTests {
    static var allTests = [
        ("testUsage", testUsage),
    ]
}

extension DelayTests {
    static var allTests = [
        ("testDelay", testDelay),
    ]
}

extension HelpersTests {
    static var allTests = [
        ("testCharacterReading", testCharacterReading),
        ("testImmediatePrinting", testImmediatePrinting),
    ]
}

extension LapTests {
    static var allTests = [
        ("testInitialization", testInitialization),
        ("testEquality", testEquality),
        ("testFormattingSingleItem", testFormattingSingleItem),
    ]
}

extension ProgramTests {
    static var allTests = [
        ("testCreation", testCreation),
    ]
}

extension TimeIntervalTests {
    static var allTests = [
        ("testFormatting", testFormatting),
    ]
}

extension TimerStatusTests {
    static var allTests = [
        ("testEquality", testEquality),
    ]
}

extension TimerTests {
    static var allTests = [
        ("testInitialization", testInitialization),
        ("testStarting", testStarting),
        ("testMultipleStarts", testMultipleStarts),
        ("testStopping", testStopping),
        ("testMultipleStops", testMultipleStops),
        ("testToggling", testToggling),
        ("testTrivialLapping", testTrivialLapping),
    ]
}

XCTMain([
    testCase(ArgumentsTests.allTests),
    testCase(CommandLineKitTests.allTests),
    testCase(DelayTests.allTests),
    testCase(HelpersTests.allTests),
    testCase(LapTests.allTests),
    testCase(ProgramTests.allTests),
    testCase(TimeIntervalTests.allTests),
    testCase(TimerStatusTests.allTests),
    testCase(TimerTests.allTests),
])
