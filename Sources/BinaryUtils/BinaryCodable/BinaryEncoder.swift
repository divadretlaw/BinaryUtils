//
//  BinaryEncoder.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

public final class BinaryEncoder {
    public var userInfo: [CodingUserInfoKey: Any]
    public var stringEncoding: String.Encoding = .utf8
    public var stringEncodingStrategy: StringEncodingStrategy = .nullTerminated

    public enum StringEncodingStrategy {
        case fixedSize(Int)
        case nullTerminated
    }

    struct Options {
        let stringEncoding: String.Encoding
        let stringEncodingStrategy: StringEncodingStrategy
        let userInfo: [CodingUserInfoKey: Any]
    }

    public init() {
        self.userInfo = [MD5.format: MD5.Format.binary]
    }

    private var options: Options {
        Options(stringEncoding: stringEncoding, stringEncodingStrategy: stringEncodingStrategy, userInfo: userInfo)
    }

    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        let encoder = DataEncoder(at: [], options: options)
        try value.encode(to: encoder)
        return encoder.data
    }
}

extension BinaryEncoder {
    enum Error: Swift.Error {
        case unsupported(_ message: String)
    }
}
