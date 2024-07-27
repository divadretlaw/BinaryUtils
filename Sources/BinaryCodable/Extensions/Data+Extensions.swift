//
//  Data+Extensions.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

extension Data {
    func fixedSize(_ size: Int) -> Data {
        let delta = size - count

        switch delta {
        case ..<0:
            return self[..<size]
        case 1...:
            return self + Data(Array(repeating: 0x0, count: delta))
        default:
            return self
        }
    }

    static var nullByte: Data {
        Data([0x0])
    }
}
