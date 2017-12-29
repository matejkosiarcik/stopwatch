//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class HelpersTests: XCTestCase {}

extension HelpersTests {
    func testCharacterReading() {
        // given
        let filePath = NSTemporaryDirectory().appending("/" + UUID().uuidString + ".txt.tmp")
        FileManager.default.createFile(atPath: filePath, contents: "abc".data(using: .ascii))
        let expected = Character("a")

        // when
        guard let reader = FileHandle(forReadingAtPath: filePath) else {
            XCTFail("Could not open file at: \(filePath)")
            return
        }
        let char = readCharacter(from: reader)

        // then
        XCTAssertEqual(char, expected)
    }

    func testImmediatePrinting() {
        // given
        let str = "foo"
        let uuid = UUID()
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("Stopwatch-\(uuid.uuidString).txt")
        let mode = "w+"
        guard let tempFile = fopen(UnsafePointer(tempURL.path), UnsafePointer(mode))
            else { XCTFail("Temporary file not opened"); return }

        // when
        report(str, to: tempFile)

        // then
        let content = try? String(contentsOf: tempURL)
        XCTAssertEqual(content, "\rfoo")
    }
}
