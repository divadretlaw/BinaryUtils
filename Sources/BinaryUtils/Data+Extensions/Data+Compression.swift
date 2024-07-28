//
//  Data+Compression.swift
//  BinaryUtils
//
//  Created by David Walter on 28.07.24.
//

import Foundation
import Compression

extension Data {
    public enum CompressionAlgorithm: Sendable {
        case lz4
        case zlib
        case lzma
        case lz4raw
        // case brotli
        case lzfse
        // case lzbitmap
        
        var rawValue: compression_algorithm {
            switch self {
            case .lz4:
                COMPRESSION_LZ4
            case .zlib:
                COMPRESSION_ZLIB
            case .lzma:
                COMPRESSION_LZMA
            case .lz4raw:
                COMPRESSION_LZ4_RAW
            // case .brotli:
            //     COMPRESSION_BROTLI
            case .lzfse:
                COMPRESSION_LZFSE
            // case .lzbitmap:
            //    COMPRESSION_LZBITMAP
            }
        }
    }
    
    public enum DecompressionAlgorithm: Sendable {
        case lz4
        case zlib
        case lzma
        case lz4raw(Int)
        // case brotli
        case lzfse
        // case lzbitmap
        
        var rawValue: compression_algorithm {
            switch self {
            case .lz4:
                COMPRESSION_LZ4
            case .zlib:
                COMPRESSION_ZLIB
            case .lzma:
                COMPRESSION_LZMA
            case .lz4raw:
                COMPRESSION_LZ4_RAW
            // case .brotli:
            //     COMPRESSION_BROTLI
            case .lzfse:
                COMPRESSION_LZFSE
            // case .lzbitmap:
            //    COMPRESSION_LZBITMAP
            }
        }
    }
}

public extension Data {
    func compressed(using algorithm: CompressionAlgorithm) throws -> Data {
        switch algorithm {
        case .lz4:
            return try compressed(using: NSData.CompressionAlgorithm.lz4)
        case .zlib:
            return try compressed(using: NSData.CompressionAlgorithm.zlib)
        case .lzma:
            return try compressed(using: NSData.CompressionAlgorithm.lzma)
        case .lz4raw:
            return try compressed(size: Swift.max(count, 128), algorithm: algorithm.rawValue)
        case .lzfse:
            return try compressed(using: NSData.CompressionAlgorithm.lzfse)
        }
    }
    
    func decompressed(using algorithm: DecompressionAlgorithm) throws -> Data {
        switch algorithm {
        case .lz4:
            return try decompressed(using: NSData.CompressionAlgorithm.lz4)
        case .zlib:
            return try decompressed(using: NSData.CompressionAlgorithm.zlib)
        case .lzma:
            return try decompressed(using: NSData.CompressionAlgorithm.lzma)
        case let .lz4raw(size):
            return try decompressed(size: size, algorithm: algorithm.rawValue)
        case .lzfse:
            return try decompressed(using: NSData.CompressionAlgorithm.lzfse)
        }
    }
    
    @_disfavoredOverload
    func decompressed(using algorithm: NSData.CompressionAlgorithm) throws -> Data {
        try (self as NSData).decompressed(using: algorithm) as Data
    }
    
    @_disfavoredOverload
    func compressed(using algorithm: NSData.CompressionAlgorithm) throws -> Data {
        try (self as NSData).compressed(using: algorithm) as Data
    }
}

private extension Data {
    func decompressed(size: Int, algorithm: compression_algorithm) throws -> Data {
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        
        return try withUnsafeBytes { sourceBuffer in
            let typedPointer = sourceBuffer.bindMemory(to: UInt8.self)
            
            let compressedSize = compression_decode_buffer(
                destinationBuffer,
                size,
                typedPointer.baseAddress!, // swiftlint:disable:this force_unwrapping
                count,
                nil,
                algorithm
            )
            
            if compressedSize == 0 {
                throw CocoaError(CocoaError.Code(rawValue: 5377))
            }
            
            return Data(bytesNoCopy: destinationBuffer, count: size, deallocator: .free)
        }
    }
    
    func compressed(size: Int, algorithm: compression_algorithm) throws -> Data {
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        
        return try withUnsafeBytes { sourceBuffer in
            let typedPointer = sourceBuffer.bindMemory(to: UInt8.self)
            
            let compressedSize = compression_encode_buffer(
                destinationBuffer,
                size,
                typedPointer.baseAddress!, // swiftlint:disable:this force_unwrapping,
                count,
                nil,
                algorithm
            )
            
            if compressedSize == 0 {
                throw CocoaError(CocoaError.Code(rawValue: 5377))
            }
            
            return Data(bytesNoCopy: destinationBuffer, count: compressedSize, deallocator: .free)
        }
    }
}
