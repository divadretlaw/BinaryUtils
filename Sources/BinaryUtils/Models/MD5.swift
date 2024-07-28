//
//  MD5.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

public struct MD5: Hashable, Equatable, CustomStringConvertible, Codable, Sendable {
    // swiftlint:disable:next large_tuple
    public let md5: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    public init() {
        md5 = UUID().uuid
    }

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
        lhs.hashValue == rhs.hashValue
    }
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        md5String
    }
    
    // MARK: - Codable
    
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
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
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        
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
    }
}