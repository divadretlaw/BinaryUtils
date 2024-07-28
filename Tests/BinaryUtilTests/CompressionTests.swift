import XCTest
@testable import BinaryUtils
import Compression

final class CompressionTests: XCTestCase {
    func testLZ4() throws {
        let data = Data("Hello World".utf8)
        let compressed = try data.compressed(using: .lz4)
        let decompressed = try compressed.decompressed(using: .lz4)
        XCTAssertEqual(data, decompressed)
    }
    
    func testLZ4Raw() throws {
        let data = Data("Hello World".utf8)
        let compressed = try data.compressed(using: .lz4raw)
        let decompressed = try compressed.decompressed(using: .lz4raw(data.count))
        XCTAssertEqual(data, decompressed)
    }
}
