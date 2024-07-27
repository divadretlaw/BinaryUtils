import Foundation

struct TestNilable: Equatable, Codable {
    let name: String
    let value: UInt32?

    init(name: String, value: UInt32?) {
        self.name = name
        self.value = value
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.name)
        try container.encode(self.value)
    }

    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.name = try container.decode(String.self)
        self.value = try container.decodeIfPresent(UInt32.self)
    }
}
