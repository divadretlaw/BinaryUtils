import XCTest
@testable import BinaryUtils

final class DataTests: XCTestCase {
    func testCRC32() throws {
        let string = "The quick brown fox jumps over the lazy dog"
        let data = Data(string.utf8)
        let crc = data.crc32()
        XCTAssertEqual(crc, 0x414FA339)
    }
}
