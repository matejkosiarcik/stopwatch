//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

@testable import Core
import XCTest

final class ArgumentsTests: XCTestCase {}

// MARK: - Creation
extension ArgumentsTests {
    func testInitialization() {
        // given
        let expected: (Bool) = (false)

        // when
        let args = Arguments(help: false, usage: "")

        // then
        XCTAssertEqual(args.help, expected)
    }

    func testUnsuccessfulParsing() {
        // given
        let arguments = [
            ["", "-bar"],
            ["", "--bar"],
            ["", "---bar"],
            ["", "-h", "-foo"],
            ["", "-h", "--foo"],
            [", ", "-h", "---foo"],
        ]

        // when
        let tested = arguments.map { Arguments.new(from: $0) }

        // then
        tested.enumerated().forEach {
            switch $0.element {
            case .success(let x): XCTFail(String(describing: x) + " " + $0.offset.description)
            case .failure: break
            }
        }
    }

    func testSuccessfulParsing() {
        // given
        let arguments = [
            ["", "-h"],
            ["", "--help"],
            ]

        // when
        let tested = arguments.map { Arguments.new(from: $0) }

        // then
        tested.enumerated().forEach {
            switch $0.element {
            case .success: break
            case .failure(let x): XCTFail(String(describing: x) + " " + $0.offset.description)
            }
        }
    }
}

// MARK: - Errors
extension ArgumentsTests {
    func testErrorDescription() {
        // given
        let error = Arguments.Error.passed("Foo")
        let expected = "Foo"

        // when
        let description = error.description

        // then
        XCTAssertEqual(description, expected)
    }
}
