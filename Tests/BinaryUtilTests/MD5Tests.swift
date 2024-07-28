import XCTest
@testable import BinaryUtils
import Compression

final class MD5Tests: XCTestCase {
    func testString() throws {
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
}
