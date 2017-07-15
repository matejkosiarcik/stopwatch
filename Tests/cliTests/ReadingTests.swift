//
// ReadingTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class ReadingTest: XCTestCase {}

extension ReadingTest {
    func testReadingSingleCharacter() {
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
}
