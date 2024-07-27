import XCTest
@testable import BinaryCodable
import Compression

final class DataEncoderTests: XCTestCase {
    func testStringSingleValue() throws {
        let encoder = BinaryEncoder()
        let data = try encoder.encode("@")
        XCTAssertEqual(data, Data([0x40]))
    }

    func testUInt8SingleValue() throws {
        let encoder = BinaryEncoder()
        let data = try encoder.encode(0x40 as UInt8)
        XCTAssertEqual(data, Data(0x40 as UInt8))
    }

    func testUInt64SingleValue() throws {
        let encoder = BinaryEncoder()
        let data = try encoder.encode(0x40 as UInt64)
        XCTAssertEqual(data, Data(0x40 as UInt64))
    }

    func testUnkeyedContainerBasic() throws {
        let encoder = BinaryEncoder()
        encoder.stringEncodingStrategy = .nullTerminated
        let value = Test(name: "Hello World", value: 42)
        let data = try encoder.encode(value)
        // Test with Decoder
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        XCTAssertEqual(value, try decoder.decode(Test.self, from: data))
    }

    func testUnkeyedContainerNilable() throws {
        let encoder = BinaryEncoder()
        let decoder = BinaryDecoder()

        let valueNil = TestNilable(name: "Hello World", value: nil)
        let dataNil = try encoder.encode(valueNil)
        // Test with Decoder
        XCTAssertEqual(valueNil, try decoder.decode(TestNilable.self, from: dataNil))

        let valueNotNil = TestNilable(name: "Hello World", value: 42)
        let dataNotNil = try encoder.encode(valueNotNil)
        // Test with Decoder
        XCTAssertEqual(valueNotNil, try decoder.decode(TestNilable.self, from: dataNotNil))
    }

    func testUnkeyedContainerNullTerminatedStrings() throws {
        let encoder = BinaryEncoder()
        encoder.stringEncodingStrategy = .nullTerminated
        let value = TestStrings("Hello", "World")
        let data = try encoder.encode(value)
        // Test with Decoder
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .nullTerminated
        XCTAssertEqual(value, try decoder.decode(TestStrings.self, from: data))
    }

    func testUnkeyedContainerFixedSizeStrings() throws {
        let encoder = BinaryEncoder()
        encoder.stringEncodingStrategy = .fixedSize(16)
        let value = TestStrings("Hello", "World")
        let data = try encoder.encode(value)
        // Test with Decoder
        let decoder = BinaryDecoder()
        decoder.stringDecodingStrategy = .fixedSize(16)
        XCTAssertEqual(value, try decoder.decode(TestStrings.self, from: data))
    }

    func testNested() throws {
        let encoder = BinaryEncoder()
        let value = TestNested(
            meta: Test(name: "Key", value: 42),
            values: []
        )
        let data = try encoder.encode(value)
        // Test with Decoder
        let decoder = BinaryDecoder()
        XCTAssertEqual(value, try decoder.decode(TestNested.self, from: data))
    }
}
