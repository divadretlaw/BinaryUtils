//
//  BinaryCodingKey.swift
//  BinaryCodable
//
//  Created by David Walter on 27.07.24.
//

import Foundation

struct BinaryCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = intValue.description
        self.intValue = intValue
    }

    // swiftlint:disable:next force_unwrapping
    static let superKey = BinaryCodingKey(stringValue: "super")!
}
