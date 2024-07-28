import Foundation

struct TestMixed: Equatable, Codable {
    let keyed: TestKeyed
    let unkeyed: TestUnkeyed

    init(keyed: TestKeyed, unkeyed: TestUnkeyed) {
        self.keyed = keyed
        self.unkeyed = unkeyed
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.keyed)
        try container.encode(self.unkeyed)
    }

    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.keyed = try container.decode(TestKeyed.self)
        self.unkeyed = try container.decode(TestUnkeyed.self)
    }
}
