//
//  ASCII+Character.swift
//  BinaryUtils
//
//  Created by David Walter on 25.08.24.
//

import Foundation

public extension Character {
    init(ascii: ASCII) {
        self.init(Unicode.Scalar(ascii.rawValue))
    }
}
