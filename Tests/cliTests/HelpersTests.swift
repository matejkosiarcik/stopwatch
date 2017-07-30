//
// HelpersTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class HelpersTests: XCTestCase {}

extension HelpersTests {
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

    func testImmediatePrinting() {
        // given
        let str = "foo"
        let uuid = UUID()
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("StopWatch-\(uuid.uuidString).txt")
        let mode = "w+"
        guard let tempFile = fopen(UnsafePointer(tempURL.path), UnsafePointer(mode)) else { XCTFail("Temporary file not opened"); return }

        // when
        flushPrint(str, to: tempFile)

        // then
        let content = try? String(contentsOf: tempURL)
        XCTAssertEqual(content, "foo\r")
    }
}
