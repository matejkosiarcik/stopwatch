//
// ReadingTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class ReadingTest: XCTestCase {}

extension ReadingTest {
    func testReadingSingleCharacter() {
        // given
        let filePath = NSTemporaryDirectory().appending("/" + UUID().uuidString + ".txt.tmp")
        FileManager.default.createFile(atPath: filePath, contents: "abc".data(using: .ascii))

        // when
        guard let reader = FileHandle(forReadingAtPath: filePath) else { XCTFail(); return }
        let char = readCharacter(from: reader)

        // then
        expect(char) == Character("a")
    }
}
