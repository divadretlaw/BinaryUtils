//
//  BinaryDecoder.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

public final class BinaryDecoder {
    private let userInfo: [CodingUserInfoKey: Any]
    public var stringEncoding: String.Encoding = .utf8
    public var stringDecodingStrategy: StringDecodingStrategy = .nullTerminated

    public enum StringDecodingStrategy {
        case fixedSize(Int)
        case nullTerminated
    }

    struct Options {
        let stringEncoding: String.Encoding
        let stringDecodingStrategy: StringDecodingStrategy
        let userInfo: [CodingUserInfoKey: Any]
    }

    public init() {
        self.userInfo = [:]
    }

    private var options: Options {
        Options(stringEncoding: stringEncoding, stringDecodingStrategy: stringDecodingStrategy, userInfo: userInfo)
    }

    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        try T(from: DataDecoder(referencing: data, at: [], options: options))
    }

    public func decode<T>(_ type: T.Type, from fileHandle: FileHandle) throws -> T where T: Decodable {
        try T(from: FileHandleDecoder(referencing: fileHandle, at: [], options: options))
    }

    public func decode<T>(_ type: T.Type, from url: URL) throws -> T where T: Decodable {
        let fileHandle = try FileHandle(forReadingFrom: url)
        defer {
            try? fileHandle.close()
        }

        return try T(from: FileHandleDecoder(referencing: fileHandle, at: [], options: options))
    }
}

extension BinaryDecoder {
    enum Error: Swift.Error {
        case dataCorrupted
        case unsupported(_ message: String)
    }
}
