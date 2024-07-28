//
//  FileHandle+Extensions.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

public extension FileHandle {
    /// Moves the file pointer to the specified offset within the file.
    ///
    /// - Parameter offset: The offset to seek to.
    ///
    /// Throws an error if called on a file handle representing a pipe or socket,
    /// if the file descriptor is closed, or if any other error occurs while seeking.
    func seek(toOffset offset: UInt64?) throws {
        guard let offset else { return }
        try seek(toOffset: offset)
    }
    
    func readByte() throws -> UInt8? {
        if let data = try read(upToCount: MemoryLayout<UInt8>.size) {
            return data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: UInt8.self)
            }
        } else {
            return nil
        }
    }
    
    func load<T>(type: T.Type) throws -> T? {
        if let data = try read(upToCount: MemoryLayout<T>.size) {
            return data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: T.self)
            }
        } else {
            return nil
        }
    }
    
    func load<T>(type: T.Type) throws -> T? where T: RawRepresentable {        
        if let data = try read(upToCount: MemoryLayout<T.RawValue>.size) {
            let rawValue = data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: T.RawValue.self)
            }
            return T(rawValue: rawValue)
        } else {
            return nil
        }
    }
    
    func loadString(encoding: String.Encoding) throws -> String? {
        var rawData: [UInt8] = []

        for byte in self {
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
