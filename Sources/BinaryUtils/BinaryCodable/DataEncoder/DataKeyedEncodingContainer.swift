//
//  DataKeyedEncodingContainer.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class DataKeyedEncodingContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    private let encoder: DataEncoder

    init(referencing encoder: DataEncoder) {
        self.encoder = encoder
    }

    var codingPath: [any CodingKey] {
        encoder.codingPath
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        KeyedEncodingContainer(DataKeyedEncodingContainer<NestedKey>(referencing: encoder))
    }

    func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
        DataUnkeyedEncodingContainer(referencing: encoder)
    }

    func superEncoder() -> any Encoder {
        DataEncoder(at: encoder.codingPath + [BinaryCodingKey.superKey], options: encoder.options)
    }

    func superEncoder(forKey key: Key) -> any Encoder {
        DataEncoder(at: encoder.codingPath + [key], options: encoder.options)
    }

    func encodeNil(forKey key: Key) throws {
    }

    func encode(_ value: Bool, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: String, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Double, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Float, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int8, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int16, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int32, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int64, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt8, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt16, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt32, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt64, forKey key: Key) throws {
        try encoder.store(value)
    }

    func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        try value.encode(to: encoder)
    }
}
