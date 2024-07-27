//
//  FileHandleIterator.swift
//  BinaryCodable
//
//  Created by David Walter on 23.07.24.
//

import Foundation

struct FileHandleIterator: IteratorProtocol, Sequence {
    let fileHandle: FileHandle

    init(_ fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }

    mutating func next() -> UInt8? {
        do {
            return try fileHandle.readByte()
        } catch {
            return nil
        }
    }
}
