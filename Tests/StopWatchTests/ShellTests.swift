//
// ShellTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class ShellTest: XCTestCase {}

extension ShellTest {
    func testExitCode() {
        // given
        let command = "exit 29"
        let expected: Int32 = 29

        // when
        let exitCode = shell(command)

        // then
        expect(exitCode) == expected
    }
}
