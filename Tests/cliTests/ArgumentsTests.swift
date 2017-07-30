//
// ArgumentsTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class ArgumentsTests: XCTestCase {}

// MARK: - Creation
extension ArgumentsTests {
    func testInitialization() {
        // given
        let expected = (help: false, version: true)

        // when
        let args = Arguments(path: "", help: false, version: true, usage: "")

        // then
        XCTAssertEqual(args.help, expected.help)
        XCTAssertEqual(args.version, expected.version)
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
            ["", "-V"],
            ["", "--version"],
            ["", "--help"],
            ["", "-h", "-V"],
            ["", "-V", "--help"],
            ["", "-hV"],
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

// MARK: - Helpers
extension ArgumentsTests {
    func testExecutablePathFileName() {
        // given
        let args = ["/dev/null", "/foo", "./bar", "../foo/bar/baz", "file", ""]
            .map { Arguments(path: $0, help: false, version: false, usage: "") }
        let expected = ["null", "foo", "bar", "baz", "file", ""]

        // when
        let tested = args.map { $0.executableFileName }

        // then
        XCTAssertEqual(tested, expected)
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
