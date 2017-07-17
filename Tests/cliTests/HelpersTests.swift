//
// HelpersTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class HelpersTest: XCTestCase {}

extension HelpersTest {
    func testCharacterReading() {
        // given
        let filePath = NSTemporaryDirectory().appending("/" + UUID().uuidString + ".txt.tmp")
        FileManager.default.createFile(atPath: filePath, contents: "abc".data(using: .ascii))
        let expected = Character("a")

        // when
        guard let reader = FileHandle(forReadingAtPath: filePath) else { XCTFail(); return }
        let char = readCharacter(from: reader)

        // then
        XCTAssertEqual(char, expected)
    }

    func testShellExitCode() {
        // given
        let command = "exit 42"
        let expected: Int32 = 42

        // when
        let exitCode = shell(command)

        // then
        XCTAssertEqual(exitCode, expected)
    }
}
