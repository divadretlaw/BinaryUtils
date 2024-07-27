//
//  BinaryEncoder.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

public final class BinaryEncoder {
    private let userInfo: [CodingUserInfoKey: Any]
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
        self.userInfo = [:]
    }

    private var options: Options {
        Options(stringEncoding: stringEncoding, stringEncodingStrategy: stringEncodingStrategy, userInfo: userInfo)
    }

    func encode<T>(_ value: T) throws -> Data where T: Encodable {
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
