//
//  FileHandleKeyedDecodingContainer.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class FileHandleKeyedDecodingContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
    private let decoder: FileHandleDecoder
    var allKeys: [Key]

    init(referencing decoder: FileHandleDecoder) {
        self.allKeys = []
        self.decoder = decoder
    }

    var codingPath: [any CodingKey] {
        decoder.codingPath
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        KeyedDecodingContainer(FileHandleKeyedDecodingContainer<NestedKey>(referencing: decoder))
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> any UnkeyedDecodingContainer {
        FileHandleUnkeyedDecodingContainer(referencing: decoder)
    }

    func superDecoder() throws -> any Decoder {
        FileHandleDecoder(referencing: decoder.storage, at: decoder.codingPath + [BinaryCodingKey.superKey], options: decoder.options)
    }

    func superDecoder(forKey key: Key) throws -> any Decoder {
        FileHandleDecoder(referencing: decoder.storage, at: decoder.codingPath + [key], options: decoder.options)
    }

    func contains(_ key: Key) -> Bool {
        true
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        false
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try decoder.load(type: type)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try decoder.loadString()
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try decoder.load(type: type)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try decoder.load(type: type)
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try decoder.load(type: type)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try decoder.load(type: type)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try decoder.load(type: type)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try decoder.load(type: type)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        try type.init(from: decoder)
    }
}
