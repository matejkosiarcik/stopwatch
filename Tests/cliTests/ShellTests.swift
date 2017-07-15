//
// ShellTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

@testable import cli
import XCTest

final class ShellTest: XCTestCase {}

extension ShellTest {
    func testExitCode() {
        // given
        let command = "exit 42"
        let expected: Int32 = 42

        // when
        let exitCode = shell(command)

        // then
        XCTAssertEqual(exitCode, expected)
    }
}
