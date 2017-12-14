//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import XCTest

extension XCTestCase {
    func delay(_ duration: TimeInterval) {
        let exp = expectation(description: "Generic delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { exp.fulfill() }
        wait(for: [exp], timeout: duration + 0.05)
    }
}
