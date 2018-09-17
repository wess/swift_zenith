import XCTest
@testable import zenith

final class zenithTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(zenith().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
