import Foundation

struct Resource {
    let name: String
    let ext: String?
    let url: URL

    init(name: String, withExtension ext: String?, sourceFile: StaticString = #file) {
        self.name = name
        self.ext = ext

        let testsSourceURL = URL(fileURLWithPath: "\(sourceFile)", isDirectory: false)
        let sourceURL = testsSourceURL.deletingLastPathComponent()
        let resourcesURL = sourceURL.deletingLastPathComponent().appendingPathComponent("Resources", isDirectory: true)
        let pathComponent = [name, ext]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: ".")
        self.url = resourcesURL.appendingPathComponent(pathComponent, isDirectory: false)
    }
}
