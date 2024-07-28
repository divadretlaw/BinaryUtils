//
//  Data+Init.swift
//  BinaryUtils
//
//  Created by David Walter on 28.07.24.
//

import Foundation

public extension Data {
    // MARK: Unsigned Integer
    
    init(_ value: UInt) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt>.size)
    }
    
    init(_ value: UInt8) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt8>.size)
    }
    
    init(_ value: UInt16) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt16>.size)
    }

    init(_ value: UInt32) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt32>.size)
    }

    init(_ value: UInt64) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt64>.size)
    }
    
    // MARK: Signed Integer
    
    init(_ value: Int) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<Int>.size)
    }
    
    init(_ value: Int8) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<Int8>.size)
    }
    
    init(_ value: Int16) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<Int16>.size)
    }

    init(_ value: Int32) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<Int32>.size)
    }

    init(_ value: Int64) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<Int64>.size)
    }
}