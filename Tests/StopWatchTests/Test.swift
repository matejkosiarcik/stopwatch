import XCTest
@testable import StopWatch

final class Test: XCTestCase {}

extension Test {
    func test() {
        XCTAssertEqual(foo(), 42)
    }
}
