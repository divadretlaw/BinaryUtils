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
    
    // MARK: - Generic
    
    func load<T>(fromByteOffset offset: UInt64? = nil, type: T.Type) throws -> T? {
        try seek(toOffset: offset)
        
        if let data = try read(upToCount: MemoryLayout<T>.size) {
            return data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: T.self)
            }
        } else {
            return nil
        }
    }
    
    func load<T>(fromByteOffset offset: UInt64? = nil, type: T.Type) throws -> T? where T: RawRepresentable {
        try seek(toOffset: offset)
        
        if let data = try read(upToCount: MemoryLayout<T.RawValue>.size) {
            let rawValue = data.withUnsafeBytes { pointer in
                pointer.loadUnaligned(as: T.RawValue.self)
            }
            return T(rawValue: rawValue)
        } else {
            return nil
        }
    }
    
    // MARK: - Data
    
    func loadData(fromByteOffset offset: UInt64? = nil, upToCount: Int) throws -> Data? {
        try seek(toOffset: offset)
        return try read(upToCount: upToCount)
    }
    
    func loadData(fromByteOffset offset: UInt64? = nil, upToCount: UInt32) throws -> Data? {
        try loadData(fromByteOffset: offset, upToCount: Int(upToCount))
    }
    
    func loadData(fromByteOffset offset: UInt64? = nil, upToCount: UInt64) throws -> Data? {
        try loadData(fromByteOffset: offset, upToCount: Int(upToCount))
    }
    
    // MARK: - String
    
    func loadString(fromByteOffset offset: UInt64? = nil, encoding: String.Encoding) throws -> String? {
        try seek(toOffset: offset)
        
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
    
    func loadString(
        fromByteOffset offset: UInt64? = nil,
        encoding: String.Encoding,
        upToCount: Int
    ) throws -> String? {
        guard let data = try loadData(upToCount: upToCount) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
}
