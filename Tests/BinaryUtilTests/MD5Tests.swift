import XCTest
@testable import BinaryUtils
import Compression

final class MD5Tests: XCTestCase {
    func testMd5String() throws {
        let string = "09f7e02f1290be211da707a266f153b3"
        let md5 = MD5(md5String: string)
        XCTAssertNotNil(md5)
    }
    
    func testJsonEncoder() throws {
        let md5 = MD5()
        let data = try JSONEncoder().encode(md5)
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
    }
    
    func testJsonDecoder() throws {
        let json = "[\"09f7e02f1290be211da707a266f153b3\"]"
        let data = Data(json.utf8)
        let md5 = try JSONDecoder().decode([MD5].self, from: data)
        print(md5)
    }
    
    func testBinaryEncoder() throws {
        let md5 = MD5()
        let data = try BinaryEncoder().encode(md5)
        print(data.hexDescription)
    }
    
    func testBinaryDecoder() throws {
        let data = try XCTUnwrap(Data(hexString: "4139124A22F247E494ACAA5800BEB1D8"))
        let md5 = try BinaryDecoder().decode(MD5.self, from: data)
        XCTAssertEqual(md5.md5String, "4139124a22f247e494acaa5800beb1d8")
    }
    
    func testMD5Size() {
        XCTAssertEqual(MemoryLayout<MD5>.size, 16)
    }
    
    func testMD5NotEqual() throws {
        let lhs = MD5()
        let rhs = MD5()
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(lhs.md5String, rhs.md5String)
        let jsonEncoder = JSONEncoder()
        XCTAssertNotEqual(try jsonEncoder.encode(lhs), try jsonEncoder.encode(rhs))
        let binaryEncoder = BinaryEncoder()
        let lhsData = try binaryEncoder.encode(lhs)
        let rhsData = try binaryEncoder.encode(rhs)
        XCTAssertNotEqual(lhsData, rhsData)
    }
    
    func testMD5Equal() throws {
        let data = Data([0x42, 0x64])
        let lhs = MD5(data: data)
        let rhs = MD5(data: data)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(lhs.md5String, rhs.md5String)
        let jsonEncoder = JSONEncoder()
        XCTAssertEqual(try jsonEncoder.encode(lhs), try jsonEncoder.encode(rhs))
        let binaryEncoder = BinaryEncoder()
        let lhsData = try binaryEncoder.encode(lhs)
        let rhsData = try binaryEncoder.encode(rhs)
        XCTAssertEqual(lhsData, rhsData)
    }
    
    func testString() throws {
        let string = "Hello World"
        let md5 = MD5(string: string)
        XCTAssertEqual(md5.md5String, "b10a8db164e0754105b7a99be72e3fe5")
        XCTAssertEqual(md5, MD5(string: string))
    }
    
    func testData() throws {
        let data = Data("Hello World".utf8)
        let md5 = MD5(data: data)
        XCTAssertEqual(md5.md5String, "b10a8db164e0754105b7a99be72e3fe5")
        XCTAssertEqual(md5, MD5(data: data))
    }
    
    func testFile() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "Basic", withExtension: "bin"))
        let md5 = try MD5(url: url)
        XCTAssertEqual(md5.md5String, "71f8b02ce15570f8179906c8971557ef")
    }
}
