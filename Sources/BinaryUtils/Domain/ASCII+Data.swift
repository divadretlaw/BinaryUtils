//
//  ASCII+Data.swift
//  BinaryUtils
//
//  Created by David Walter on 24.08.24.
//

import Foundation

public extension Data {
    /// Initialize data from the given ``ASCII`` code points
    /// - Parameter ascii: ``ASCII`` code point sequence
    init(ascii: ASCII...) {
        var bytes: [UInt8] = []
        for point in ascii {
            bytes.append(point.rawValue)
        }
        self.init(bytes)
    }
    
    /// Initialize data from the given ``ASCII`` code points
    /// - Parameter ascii: ``ASCII`` code point sequence
    init(ascii: [ASCII]) {
        var bytes: [UInt8] = []
        for point in ascii {
            bytes.append(point.rawValue)
        }
        self.init(bytes)
    }
    
    /// Initialize data from the given ASCII code point
    /// - Parameter ascii: ``ASCII`` code point
    init(ascii: ASCII) {
        self.init(ascii.rawValue)
    }
}
