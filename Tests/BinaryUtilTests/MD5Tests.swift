import XCTest
@testable import BinaryUtils
import Compression

final class MD5Tests: XCTestCase {
    func testMd5String() throws {
        let string = "09f7e02f1290be211da707a266f153b3"
        let md5 = MD5(md5String: string)
        XCTAssertNotNil(md5)
    }
    
    func testEncode() throws {
        let md5 = MD5()
        let data = try JSONEncoder().encode(md5)
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
    }
    
    func testDecoder() throws {
        let json = "[\"09f7e02f1290be211da707a266f153b3\"]"
        let data = Data(json.utf8)
        let md5 = try JSONDecoder().decode([MD5].self, from: data)
        print(md5)
    }
    
    func testMD5() {
        XCTAssertEqual(MemoryLayout<MD5>.size, 16)
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
