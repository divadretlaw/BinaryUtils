import XCTest
@testable import BinaryUtils
import Compression

final class DataDecoderTests: XCTestCase {
    func testString() throws {
        let data = Data("Hello World".utf8)
        let decoder = BinaryDecoder()
        let string = try decoder.decode(String.self, from: data)
        XCTAssertEqual(string, "Hello World")
    }

    func testStringArrayNullTerminated() throws {
        let data = Data("Hello".utf8) + Data.nullByte + Data("World".utf8)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let string = try decoder.decode([String].self, from: data)
        XCTAssertEqual(string, ["Hello", "World"])
    }

    func testStringArrayFixedSize() throws {
        let data = Data("Hello".utf8).padding(toLength: 16) + Data("World".utf8).padding(toLength: 16)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(16)
        let string = try decoder.decode([String].self, from: data)
        XCTAssertEqual(string, ["Hello", "World"])
    }

    func testUInt8() throws {
        let data = Data([42])
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: data)
        XCTAssertEqual(value, 42)
    }

    func testUInt8Array() throws {
        let bytes: [UInt8] = [42, 64]
        let data = Data(bytes)
        let decoder = BinaryDecoder()
        let value = try decoder.decode([UInt8].self, from: data)
        XCTAssertEqual(value, [42, 64])
    }

    func testUInt64() throws {
        let data = Data(42 as UInt64)
        let decoder = BinaryDecoder()
        let value = try decoder.decode(UInt8.self, from: data)
        XCTAssertEqual(value, 42)
    }

    func testUInt64Array() throws {
        let data = Data(42 as UInt64) + Data(64 as UInt64)
        let decoder = BinaryDecoder()
        let value = try decoder.decode([UInt64].self, from: data)
        XCTAssertEqual(value, [42, 64])
    }

    func testUnkeyedContainerBasic() throws {
        let data = Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(TestUnkeyed.self, from: data)
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
        let data = Data("Hello".utf8).padding(toLength: 256) + Data("World".utf8).padding(toLength: 256)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(256)
        let strings = try decoder.decode(TestStrings.self, from: data)
        XCTAssertEqual(strings.key, "Hello")
        XCTAssertEqual(strings.value, "World")
    }

    func testKeyedContainerBasic() throws {
        let data = Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(TestKeyed.self, from: data)
        XCTAssertEqual(test.name, "Hello World")
        XCTAssertEqual(test.value, 42)
    }

    func testMixed() throws {
        let data = Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32) + Data("Hello World".utf8) + Data.nullByte + Data(42 as UInt32)
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        let test = try decoder.decode(TestMixed.self, from: data)
        XCTAssertEqual(test.keyed.name, "Hello World")
        XCTAssertEqual(test.keyed.value, 42)
        XCTAssertEqual(test.unkeyed.name, "Hello World")
        XCTAssertEqual(test.unkeyed.value, 42)
    }
}
