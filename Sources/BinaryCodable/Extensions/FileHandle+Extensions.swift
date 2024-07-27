//
//  FileHandle+Extensions.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

extension FileHandle {
    func readByte() throws -> UInt8? {
        if let data = try read(upToCount: MemoryLayout<UInt8>.size) {
            return data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: UInt8.self)
            }
        } else {
            return nil
        }
    }

    func load<T>(as type: T.Type) throws -> T? {
        if let data = try read(upToCount: MemoryLayout<T>.size) {
            return data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: T.self)
            }
        } else {
            return nil
        }
    }

    func loadString(encoding: String.Encoding) throws -> String? {
        var rawData: [UInt8] = []

        let iterator = FileHandleIterator(self)

        for byte in iterator {
            if byte != 0 {
                rawData.append(byte)
            } else {
                break
            }
        }

        let data = Data(rawData)
        return String(data: data, encoding: encoding)
    }
}
