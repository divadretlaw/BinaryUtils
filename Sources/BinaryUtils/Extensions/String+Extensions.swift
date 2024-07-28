//
//  String+Extensions.swift
//  BinaryUtils
//
//  Created by David Walter on 27.07.24.
//

import Foundation

extension String {
    func chunked(into size: Int) -> [Substring] {
        stride(from: 0, to: count, by: size).map {
            let startIndex = index(startIndex, offsetBy: $0)
            let endIndex = min(index(startIndex, offsetBy: size), endIndex)
            return self[startIndex ..< endIndex]
        }
    }
}
