import Foundation

struct TestKeyed: Equatable, Codable {
    let name: String
    let value: UInt32

    init(name: String, value: UInt32) {
        self.name = name
        self.value = value
    }

    enum CodingKeys: CodingKey {
        case name
        case value
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.value = try container.decode(UInt32.self, forKey: .value)

    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.name, forKey: .name)
        try container.encode(self.value, forKey: .value)
    }
}
