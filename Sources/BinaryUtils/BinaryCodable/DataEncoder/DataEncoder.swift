//
//  DataEncoder.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

final class DataEncoder: Encoder {
    var data: Data
    let codingPath: [CodingKey]
    let options: BinaryEncoder.Options

    init(at codingPath: [CodingKey], options: BinaryEncoder.Options) {
        self.data = Data()
        self.codingPath = codingPath
        self.options = options
    }

    func store(_ value: Bool) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<Bool>.size)
    }

    func storeSingle(_ value: String) throws {
        guard let string = value.data(using: options.stringEncoding) else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath, debugDescription: "Unable to encode given String using '\(options.stringEncoding)'"))
        }
        switch options.stringEncodingStrategy {
        case .fixedSize(let size):
            data += string.padding(toLength: size, withPad: 0x0)
        case .nullTerminated:
            data += string
        }
    }

    func store(_ value: String) throws {
        guard let string = value.data(using: options.stringEncoding) else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath, debugDescription: "Unable to encode given String using '\(options.stringEncoding)'"))
        }
        switch options.stringEncodingStrategy {
        case .fixedSize(let size):
            data += string.padding(toLength: size, withPad: 0x0)
        case .nullTerminated:
            data += string + Data.nullByte
        }
    }

    func store(_ value: Double) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<Double>.size)
    }

    func store(_ value: Float) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<Float>.size)
    }

    func store(_ value: Int) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<Int>.size)
    }

    func store(_ value: Int8) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt8>.size)
    }

    func store(_ value: Int16) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt16>.size)
    }

    func store(_ value: Int32) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt32>.size)
    }

    func store(_ value: Int64) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt64>.size)
    }

    func store(_ value: UInt) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt>.size)
    }

    func store(_ value: UInt8) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt8>.size)
    }

    func store(_ value: UInt16) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt16>.size)
    }

    func store(_ value: UInt32) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt32>.size)
    }

    func store(_ value: UInt64) throws {
        var copy = value
        data += Data(bytes: &copy, count: MemoryLayout<UInt64>.size)
    }

    // MARK: - Encoder

    var userInfo: [CodingUserInfoKey: Any] {
        options.userInfo
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        KeyedEncodingContainer(DataKeyedEncodingContainer(referencing: self))
    }

    func unkeyedContainer() -> any UnkeyedEncodingContainer {
        DataUnkeyedEncodingContainer(referencing: self)
    }

    func singleValueContainer() -> any SingleValueEncodingContainer {
        DataSingleValueEncodingContainer(referencing: self)
    }
}
