import XCTest
@testable import BinaryUtils
import Compression

final class FileHandlerDecoderTests: XCTestCase {
    func testString() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "String", withExtension: "bin"))
        let decoder = BinaryDecoder()
        let string = try decoder.decode(String.self, from: url)
        XCTAssertEqual(string, "Hello World")
    }

    func testUInt8() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "UInt8", withExtension: "bin"))
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: url)
        XCTAssertEqual(value, 42)
    }

    func testUInt64() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "UInt64", withExtension: "bin"))
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt64.self, from: url)
        XCTAssertEqual(value, 42)
    }

    func testUnkeyedContainerBasic() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "Basic", withExtension: "bin"))
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(TestUnkeyed.self, from: url)
        XCTAssertEqual(test.name, "Hello World")
        XCTAssertEqual(test.value, 42)
    }

    func testUnkeyedContainerNullTerminatedStrings() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "NullTerminatedStrings", withExtension: "bin"))
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let strings = try decoder.decode(TestStrings.self, from: url)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }

    func testUnkeyedContainerFixedSizeStrings() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "FixedSizeStrings", withExtension: "bin"))
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(16)
        let strings = try decoder.decode(TestStrings.self, from: url)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }
}
