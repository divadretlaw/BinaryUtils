//
//  MD5.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation
import CryptoKit

public struct MD5: Hashable, Equatable, CustomStringConvertible, Codable, Sendable {
    public static let format: CodingUserInfoKey = CodingUserInfoKey(rawValue: "BinaryUtils.MD5.Format")!
    
    public enum Format {
        case binary
        case string
    }
    
    // swiftlint:disable:next large_tuple
    public let md5: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    // MARK: - Init
    
    public init() {
        md5 = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    }
    
    // MARK: String
    
    public init(string: String) {
        self.init(data: Data(string.utf8))
    }
    
    // MARK: Data
    
    public init(data: Data) {
        self.init(data: [data])
    }
    
    public init(data: [Data]) {
        var digest = Insecure.MD5()
        for data in data {
            digest.update(data: data)
        }
        
        let bytes = Data(digest.finalize())
        md5 = (
            bytes[0],
            bytes[1],
            bytes[2],
            bytes[3],
            bytes[4],
            bytes[5],
            bytes[6],
            bytes[7],
            bytes[8],
            bytes[9],
            bytes[10],
            bytes[11],
            bytes[12],
            bytes[13],
            bytes[14],
            bytes[15]
        )
    }
    
    // MARK: URL
    
    public init(url: URL) throws {
        try self.init(urls: [url])
    }
    
    public init(urls: [URL]) throws {
        var digest = Insecure.MD5()
        for url in urls {
            let fileHandle = try FileHandle(forReadingFrom: url)
            if let data = try fileHandle.readToEnd() {
                digest.update(data: data)
            }
            try fileHandle.close()
        }
        
        let bytes = Data(digest.finalize())
        md5 = (
            bytes[0],
            bytes[1],
            bytes[2],
            bytes[3],
            bytes[4],
            bytes[5],
            bytes[6],
            bytes[7],
            bytes[8],
            bytes[9],
            bytes[10],
            bytes[11],
            bytes[12],
            bytes[13],
            bytes[14],
            bytes[15]
        )
    }
    
    // MARK: MD5 Strings

    public init?(md5String string: String) {
        let chunks = string.chunked(into: 2)
        guard chunks.count == 16 else { return nil }
        let bytes = chunks.compactMap { UInt8($0, radix: 16) }
        guard bytes.count == 16 else { return nil }
        md5 = (
            bytes[0],
            bytes[1],
            bytes[2],
            bytes[3],
            bytes[4],
            bytes[5],
            bytes[6],
            bytes[7],
            bytes[8],
            bytes[9],
            bytes[10],
            bytes[11],
            bytes[12],
            bytes[13],
            bytes[14],
            bytes[15]
        )
    }

    // MARK: - Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(md5.0)
        hasher.combine(md5.1)
        hasher.combine(md5.2)
        hasher.combine(md5.3)
        hasher.combine(md5.4)
        hasher.combine(md5.5)
        hasher.combine(md5.6)
        hasher.combine(md5.7)
        hasher.combine(md5.8)
        hasher.combine(md5.9)
        hasher.combine(md5.10)
        hasher.combine(md5.11)
        hasher.combine(md5.12)
        hasher.combine(md5.13)
        hasher.combine(md5.14)
        hasher.combine(md5.15)
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: MD5, rhs: MD5) -> Bool {
        lhs.md5.0 == rhs.md5.0 &&
        lhs.md5.1 == rhs.md5.1 &&
        lhs.md5.2 == rhs.md5.2 &&
        lhs.md5.3 == rhs.md5.3 &&
        lhs.md5.4 == rhs.md5.4 &&
        lhs.md5.5 == rhs.md5.5 &&
        lhs.md5.6 == rhs.md5.6 &&
        lhs.md5.7 == rhs.md5.7 &&
        lhs.md5.8 == rhs.md5.8 &&
        lhs.md5.9 == rhs.md5.9 &&
        lhs.md5.10 == rhs.md5.10 &&
        lhs.md5.11 == rhs.md5.11 &&
        lhs.md5.12 == rhs.md5.12 &&
        lhs.md5.13 == rhs.md5.13 &&
        lhs.md5.14 == rhs.md5.14 &&
        lhs.md5.15 == rhs.md5.15
    }
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        md5String
    }
    
    public var md5String: String {
        [
            md5.0,
            md5.1,
            md5.2,
            md5.3,
            md5.4,
            md5.5,
            md5.6,
            md5.7,
            md5.8,
            md5.9,
            md5.10,
            md5.11,
            md5.12,
            md5.13,
            md5.14,
            md5.15
        ]
        .map { String(format: "%02x", $0) }
        .joined()
    }
    
    // MARK: - Codable
    
    public init(from decoder: any Decoder) throws {
        let format = decoder.userInfo[MD5.format] as? Format ?? .string
        let container = try decoder.singleValueContainer()
        
        switch format {
        case .binary:
            md5 = (
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self),
                try container.decode(UInt8.self)
            )
        case .string:
            let md5String = try container.decode(String.self)
            
            guard let md5 = MD5(md5String: md5String) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                        debugDescription: "Attempted to decode MD5 from invalid MD5 string."))
            }
            self = md5
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        let format = encoder.userInfo[MD5.format] as? Format ?? .string
        var container = encoder.singleValueContainer()
        
        switch format {
        case .binary:
            try container.encode(md5.0)
            try container.encode(md5.1)
            try container.encode(md5.2)
            try container.encode(md5.3)
            try container.encode(md5.4)
            try container.encode(md5.5)
            try container.encode(md5.6)
            try container.encode(md5.7)
            try container.encode(md5.8)
            try container.encode(md5.9)
            try container.encode(md5.10)
            try container.encode(md5.11)
            try container.encode(md5.12)
            try container.encode(md5.13)
            try container.encode(md5.14)
            try container.encode(md5.15)

        case .string:
            try container.encode(md5String)
        }
    }
}
