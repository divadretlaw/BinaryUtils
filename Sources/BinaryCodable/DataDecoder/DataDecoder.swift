//
//  DataDecoder.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class DataDecoder: Decoder {
    let storage: Data
    let codingPath: [CodingKey]
    let options: BinaryDecoder.Options

    var offset: Data.Index

    init(referencing container: Data, at codingPath: [CodingKey], options: BinaryDecoder.Options) {
        self.storage = container
        self.codingPath = codingPath
        self.options = options

        self.offset = container.startIndex
    }

    func load<T>(type: T.Type) throws -> T {
        let startIndex = offset
        let endIndex = offset.advanced(by: MemoryLayout<T>.size)

        defer {
            self.offset = endIndex
        }

        guard endIndex <= storage.endIndex else {
            throw BinaryDecoder.Error.dataCorrupted
        }

        return storage[startIndex..<endIndex].withUnsafeBytes { pointer in
            pointer.loadUnaligned(as: T.self)
        }
    }

    func loadString() throws -> String {
        let startIndex = offset
        let endIndex: Data.Index
        switch options.stringDecodingStrategy {
        case .fixedSize(let int):
            endIndex = offset.advanced(by: int)
            self.offset = endIndex
        case .nullTerminated:
            endIndex = storage[offset...].firstIndex(of: 0x0) ?? storage.endIndex
            self.offset = endIndex.advanced(by: 1)
        }

        guard endIndex <= storage.endIndex else {
            throw BinaryDecoder.Error.dataCorrupted
        }

        let data = storage[startIndex..<endIndex]

        guard let string = String(data: data, encoding: options.stringEncoding) else {
            throw BinaryDecoder.Error.dataCorrupted
        }

        return string.trimmingCharacters(in: .controlCharacters)
    }

    // MARK: - Decoder

    var userInfo: [CodingUserInfoKey: Any] {
        options.userInfo
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        throw BinaryDecoder.Error.unsupported("Keyed Containers are not supported.")
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        DataUnkeyedDecodingContainer(referencing: self)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        DataSingleValueDecodingContainer(referencing: self)
    }

}
