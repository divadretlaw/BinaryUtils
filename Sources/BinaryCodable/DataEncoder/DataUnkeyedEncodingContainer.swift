//
//  DataUnkeyedEncodingContainer.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class DataUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    private let encoder: DataEncoder

    init(referencing encoder: DataEncoder) {
        self.encoder = encoder
    }

    var codingPath: [any CodingKey] {
        encoder.codingPath
    }

    var count: Int {
        0
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("Keyed Containers are not supported.")
    }

    func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
        DataUnkeyedEncodingContainer(referencing: encoder)
    }

    func superEncoder() -> any Encoder {
        DataEncoder(at: encoder.codingPath + [BinaryCodingKey.superKey], options: encoder.options)
    }

    func encodeNil() throws {
    }

    func encode(_ value: Bool) throws {
        try encoder.store(value)
    }

    func encode(_ value: String) throws {
        try encoder.store(value)
    }

    func encode(_ value: Double) throws {
        try encoder.store(value)
    }

    func encode(_ value: Float) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int8) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int16) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int32) throws {
        try encoder.store(value)
    }

    func encode(_ value: Int64) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt8) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt16) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt32) throws {
        try encoder.store(value)
    }

    func encode(_ value: UInt64) throws {
        try encoder.store(value)
    }

    func encode<T>(_ value: T) throws where T: Encodable {
        try value.encode(to: encoder)
    }
}
