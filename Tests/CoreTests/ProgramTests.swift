//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class ProgramTests: XCTestCase {}

// MARK: - Creation
extension ProgramTests {
    func testCreation() {
        // given
        let arguments = [
            ["", "-h"],
        ]
        let expected = [(true)].map { Arguments(help: $0, usage: "") }

        // when
        let tested = arguments.map { Program.new(for: $0).map { $0.arguments } }

        // then
        XCTAssertEqual(tested.count, expected.count)
        zip(tested, expected).enumerated().forEach {
            switch $0.element.0 {
            case .success(let x): XCTAssertEqual(x, $0.element.1)
            case .failure(let x): XCTFail(String(describing: x) + " " + $0.offset.description)
            }
        }
    }
}
