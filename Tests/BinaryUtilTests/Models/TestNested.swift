import Foundation

struct TestNested: Equatable, Codable {
    let meta: TestUnkeyed
    let values: [TestStrings]

    init(meta: TestUnkeyed, values: [TestStrings]) {
        self.meta = meta
        self.values = values
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.meta)
        try container.encode(self.values)
    }

    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.meta = try container.decode(TestUnkeyed.self)
        self.values = try container.decode([TestStrings].self)
    }
}
