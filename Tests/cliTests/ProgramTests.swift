//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import cli
import XCTest

final class ProgramTests: XCTestCase {}

// MARK: - Creation
extension ProgramTests {
    func testCreation() {
        // given
        let arguments = [
            ["", "-h"],
            ["", "-h", "--version"],
        ]
        let expected = [(true, false), (true, true)].map { Arguments(path: "", help: $0.0, version: $0.1, usage: "") }

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

// MARK: - Running
extension ProgramTests {
    func testHelpOutput() {
        // given
        let programs = [true, false]
            .map { Program(arguments: Arguments(path: "", help: true, version: $0, usage: "usage")) }
        let expected = [Program.ExitCode](repeating: 0, count: programs.count)
        var output = ""

        // when
        let exitCodes = programs.map { $0.main(output: &output) }

        // then
        XCTAssertEqual(exitCodes, expected)
        XCTAssertTrue(output.lowercased().contains("usage"))
    }

    func testVersionOutput() {
        // given
        let program = Program(arguments: Arguments(path: "", help: false, version: true, usage: ""))
        var output = ""
        let expected: Program.ExitCode = 0

        // when
        let exitCode = program.main(output: &output)

        // then
        XCTAssertEqual(exitCode, expected)
        XCTAssertTrue(output.lowercased().contains("version"))
    }
}
