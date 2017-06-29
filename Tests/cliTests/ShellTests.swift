//
// ShellTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import cli

final class ShellTest: XCTestCase {}

extension ShellTest {
    func testExitCode() {
        // given
        let command = "exit 42"
        let expected: Int32 = 42

        // when
        let exitCode = shell(command)

        // then
        expect(exitCode) == expected
    }
}
