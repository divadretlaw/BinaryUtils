import Foundation

struct TestStrings: Equatable, Codable {
    let key: String
    let value: String

    init(_ value: String, _ other: String) {
        self.key = value
        self.value = other
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.key)
        try container.encode(self.value)
    }

    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.key = try container.decode(String.self)
        self.value = try container.decode(String.self)
    }
}
