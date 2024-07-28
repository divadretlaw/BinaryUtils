//
//  FileHandleIterator.swift
//  BinaryUtils
//
//  Created by David Walter on 23.07.24.
//

import Foundation

public struct FileHandleIterator: IteratorProtocol {
    let fileHandle: FileHandle

    public init(_ fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }

    public mutating func next() -> UInt8? {
        do {
            return try fileHandle.readByte()
        } catch {
            return nil
        }
    }
}

extension FileHandle: Sequence {
    public func makeIterator() -> FileHandleIterator {
        FileHandleIterator(self)
    }
}
