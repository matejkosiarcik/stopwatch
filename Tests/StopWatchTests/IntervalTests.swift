//
// IntervalTests.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Nimble
import XCTest
@testable import StopWatch

final class IntervalTest: XCTestCase {}

extension IntervalTest {
    func testEqutability() {
        // given
        let reference = [(10.2, 1.4)].map { Interval(cumulative: $0.0, lapped: $0.1) }[0]
        let comparators = [(10.2, 1.4), (10.2, 1.5), (10.3, 1.4), (10.1, 1.3)]
            .map { Interval(cumulative: $0.0, lapped: $0.1) }
        let expected = [true] + [Bool](repeating: false, count: 3)

        // when
        let tested = comparators.map { $0 == reference }

        // then
        expect(tested) == expected
    }
}

