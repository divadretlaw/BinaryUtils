//
//  FileHandleDecoder.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class FileHandleDecoder: Decoder {
    let storage: FileHandle
    let codingPath: [CodingKey]
    let options: BinaryDecoder.Options

    init(referencing container: FileHandle, at codingPath: [CodingKey], options: BinaryDecoder.Options) {
        self.storage = container
        self.codingPath = codingPath
        self.options = options
    }

    func load<T>(type: T.Type) throws -> T {
        guard let type = try storage.load(as: T.self) else {
            throw BinaryDecoder.Error.dataCorrupted
        }
        return type
    }

    func loadString() throws -> String {
        switch options.stringDecodingStrategy {
        case .fixedSize(let size):
            guard let data = try storage.read(upToCount: size) else {
                throw BinaryDecoder.Error.dataCorrupted
            }
            guard let string = String(data: data, encoding: options.stringEncoding) else {
                throw BinaryDecoder.Error.dataCorrupted
            }
            return string.trimmingCharacters(in: .controlCharacters)
        case .nullTerminated:
            guard let type = try storage.loadString(encoding: options.stringEncoding) else {
                throw BinaryDecoder.Error.dataCorrupted
            }
            return type
        }
    }

    // MARK: - Decoder

    var userInfo: [CodingUserInfoKey: Any] {
        options.userInfo
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        throw BinaryDecoder.Error.unsupported("Keyed Containers are not supported.")
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        FileHandleUnkeyedDecodingContainer(referencing: self)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        FileHandleSingleValueDecodingContainer(referencing: self)
    }

}
