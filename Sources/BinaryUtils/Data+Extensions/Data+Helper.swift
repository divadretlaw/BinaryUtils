//
//  Data+Helper.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation
import zlib

public extension Data {
    /// Returns new data formed from the `Data` by either
    /// removing bytes from the end, or by appending as many
    /// occurrences as necessary of a given pad byte.
    func padding(toLength newLength: Int, withPad padByte: UInt8 = 0x0) -> Data {
        let delta = newLength - count

        switch delta {
        case ..<0:
            return self[..<newLength]
        case 1...:
            return self + Data(Array(repeating: padByte, count: delta))
        default:
            return self
        }
    }
    
    static var nullByte: Data {
        Data([0x0])
    }
    
    func chunked(size: Int) -> [Data] {
        guard size > 0 else { return [self] }
        var chunks: [Data] = []
        var data = self
        while !data.isEmpty {
            let startIndex = data.startIndex
            let endIndex = startIndex.advanced(by: size)
            if endIndex < data.endIndex {
                chunks.append(data[startIndex..<endIndex])
            } else {
                chunks.append(data)
            }
            data = data.dropFirst(size)
        }
        return chunks
    }
    
    var hexDescription: String {
        map { String(format: "%02X", $0) }.joined()
    }
    
    func crc32() -> uLong {
        withUnsafeBytes { ptr in
            let typedPointer = ptr.bindMemory(to: Bytef.self)
            return zlib.crc32(0, typedPointer.baseAddress, uInt(count))
        }
    }
}
