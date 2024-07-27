import Foundation

extension Data {
    init(_ value: UInt8) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt8>.size)
    }

    init(_ value: UInt32) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt32>.size)
    }

    init(_ value: UInt64) {
        var copy = value
        self = Data(bytes: &copy, count: MemoryLayout<UInt64>.size)
    }
}
