//
// ArgumentsTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class ArgumentsTest: XCTestCase {}

extension ArgumentsTest {
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
