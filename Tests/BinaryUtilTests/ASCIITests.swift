import XCTest
@testable import BinaryUtils
import Compression

final class ASCIITests: XCTestCase {
    func testASCII() throws {
        for ascii in ASCII.allCases {
            print("\(ascii) - \(ascii.cEscapeSequence)")
            XCTAssertTrue(Character(ascii: ascii).isASCII)
        }
    }
    
    func testPrintable() {
        let printable = ASCII.allCases.filter { $0.isPrintable }
        XCTAssertEqual(printable.count, 95)
    }
    
    func testNonPrintable() {
        let printable = ASCII.allCases.filter {!$0.isPrintable }
        XCTAssertEqual(printable.count, 33)
    }
}
