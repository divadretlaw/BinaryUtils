//
//  FileHandleUnkeyedDecodingContainer.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class FileHandleUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    private let decoder: FileHandleDecoder

    init(referencing decoder: FileHandleDecoder) {
        self.decoder = decoder
    }

    var codingPath: [any CodingKey] {
        decoder.codingPath
    }

    var count: Int? {
        nil
    }

    var isAtEnd: Bool {
        false
    }

    var currentIndex: Int {
        0
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        throw BinaryDecoder.Error.unsupported("Keyed Containers are not supported.")
    }

    func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
        FileHandleUnkeyedDecodingContainer(referencing: decoder)
    }

    func superDecoder() throws -> any Decoder {
        fatalError()
    }

    func decodeNil() -> Bool {
        false
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try decoder.load(type: type)
    }

    func decode(_ type: String.Type) throws -> String {
        try decoder.loadString()
    }

    func decode(_ type: Double.Type) throws -> Double {
        try decoder.load(type: type)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try decoder.load(type: type)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try decoder.load(type: type)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decoder.load(type: type)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try type.init(from: decoder)
    }
}
