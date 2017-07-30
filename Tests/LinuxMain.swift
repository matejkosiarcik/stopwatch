// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
// Sourcery.LinuxMain.swift.stencil - original
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cliTests
@testable import libTests

extension ArgumentsTests {
    static var allTests = [
        ("testInitialization", testInitialization),
        ("testUnsuccessfulParsing", testUnsuccessfulParsing),
        ("testSuccessfulParsing", testSuccessfulParsing),
        ("testExecutablePathFileName", testExecutablePathFileName),
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
        ("testShellExitCode", testShellExitCode),
    ]
}

extension LapTests {
    static var allTests = [
        ("testFormattingSingleItem", testFormattingSingleItem),
        ("testFormattingMultipleItems", testFormattingMultipleItems),
        ("testInitialization", testInitialization),
        ("testEquality", testEquality),
    ]
}

extension ProgramTests {
    static var allTests = [
        ("testCreation", testCreation),
        ("testHelpOutput", testHelpOutput),
        ("testVersionOutput", testVersionOutput),
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
        ("testStationaryLaps", testStationaryLaps),
        ("testTrivialLapping", testTrivialLapping),
        ("testComplicatedLapping", testComplicatedLapping),
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
