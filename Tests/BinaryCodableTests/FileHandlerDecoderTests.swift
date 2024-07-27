import XCTest
@testable import BinaryCodable
import Compression

final class FileHandlerDecoderTests: XCTestCase {
    func testString() throws {
        let resource = Resource(name: "String", withExtension: "bin")
        let decoder = BinaryDecoder()
        let string = try decoder.decode(String.self, from: resource.url)
        XCTAssertEqual(string, "Hello World")
    }

    func testUInt8() throws {
        let resource = Resource(name: "UInt8", withExtension: "bin")
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: resource.url)
        XCTAssertEqual(value, 42)
    }

    func testUInt64() throws {
        let resource = Resource(name: "UInt64", withExtension: "bin")
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt64.self, from: resource.url)
        XCTAssertEqual(value, 42)
    }

    func testUnkeyedContainerBasic() throws {
        let resource = Resource(name: "Basic", withExtension: "bin")
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(TestUnkeyed.self, from: resource.url)
        XCTAssertEqual(test.name, "Hello World")
        XCTAssertEqual(test.value, 42)
    }

    func testUnkeyedContainerNullTerminatedStrings() throws {
        let resource = Resource(name: "NullTerminatedStrings", withExtension: "bin")
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let strings = try decoder.decode(TestStrings.self, from: resource.url)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }

    func testUnkeyedContainerFixedSizeStrings() throws {
        let resource = Resource(name: "FixedSizeStrings", withExtension: "bin")
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(16)
        let strings = try decoder.decode(TestStrings.self, from: resource.url)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }
}
