import XCTest
@testable import BinaryCodable
import Compression

final class DataDecoderTests: XCTestCase {
    func testStringSingleValue() throws {
        let data = Data("Hello World".utf8)
        let decoder = BinaryDecoder()
        let string = try decoder.decode(String.self, from: data)
        XCTAssertEqual(string, "Hello World")
    }

    func testUInt8SingleValue() throws {
        let data = Data([42])
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: data)
        XCTAssertEqual(value, 42)
    }

    func testUInt64SingleValue() throws {
        let data = Data(42 as UInt64)
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: data)
        XCTAssertEqual(value, 42)
    }

    func testUnkeyedContainerBasic() throws {
        let data = Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(Test.self, from: data)
        XCTAssertEqual(test.name, "Hello World")
        XCTAssertEqual(test.value, 42)
    }

    func testUnkeyedContainerNilable() throws {
        let decoder = BinaryDecoder()

        let dataNil = Data("Hello World".utf8)
        let testNil = try decoder.decode(TestNilable.self, from: dataNil)
        XCTAssertEqual(testNil.name, "Hello World")
        XCTAssertNil(testNil.value)

        let data = Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32)
        let testNotNil = try decoder.decode(TestNilable.self, from: data)
        XCTAssertEqual(testNotNil.name, "Hello World")
        XCTAssertEqual(testNotNil.value, 42)
    }

    func testUnkeyedContainerNullTerminatedStrings() throws {
        let data = Data("Hello".utf8) + Data.nullByte + Data("World".utf8)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let strings = try decoder.decode(TestStrings.self, from: data)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }

    func testUnkeyedContainerFixedSizeStrings() throws {
        let data = Data("Hello".utf8).fixedSize(256) + Data("World".utf8).fixedSize(256)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(256)
        let strings = try decoder.decode(TestStrings.self, from: data)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }
}
