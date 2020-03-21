import XCTest
@testable import CGExtender

final class CGExtenderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(atanP(x: 0, y: 0), Double.pi/2)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
