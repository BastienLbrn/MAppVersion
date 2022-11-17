import XCTest
@testable import MAppVersion

final class MAppVersionTests: XCTestCase {
    
    // MARK: - AppVersionValue
    
    func test_appVersionValueInitSuccess() {
        let (major, minor, patch) = (3, 1, 2)
        let version = MAppVersionValue(major: major, minor: minor, patch: patch)
        XCTAssertEqual(version.major, major)
        XCTAssertEqual(version.minor, minor)
        XCTAssertEqual(version.patch, patch)
    }
    
    func test_appVersionValueInitFromString() {
        let test1 = "3.1.2"
        let test2 = "3.1"
        let test3 = "3."
        let expectedResult1 = MAppVersionValue(major: 3, minor: 1, patch: 2)
        let expectedResult2 = MAppVersionValue(major: 3, minor: 1, patch: 0)
        XCTAssertEqual(MAppVersionValue(from: test1), expectedResult1)
        XCTAssertEqual(MAppVersionValue(from: test2), expectedResult2)
        XCTAssertEqual(MAppVersionValue(from: test3), nil)
    }
    
    func test_appVersionValueComparable() {
        let test1 = MAppVersionValue(from: "3.1.2")!
        let test2 = MAppVersionValue(from: "3.1")!
        let test3 = MAppVersionValue(from: "2.1.1")!
        let test4 = MAppVersionValue(from: "4.0.0")!
        XCTAssertTrue(test1 > test2)
        XCTAssertTrue(test1 > test3)
        XCTAssertTrue(test1 < test4)
        XCTAssertTrue(test2 > test3)
        XCTAssertTrue(test2 < test4)
    }
}
