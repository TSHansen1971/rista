import Foundation
import SwiftUI
import UniformTypeIdentifiers

public extension UTType {
    static var ristaMarkdown: UTType {
        UTType(filenameExtension: "md") ?? .plainText
    }
}

public struct RistaDocument: FileDocument, Equatable {
    public static var readableContentTypes: [UTType] {
        [.ristaMarkdown, .plainText]
    }

    public static var writableContentTypes: [UTType] {
        [.ristaMarkdown, .plainText]
    }

    public var text: String

    public init(text: String = "# Nytt dokument\n\nSkriv markdown her.\n") {
        self.text = text
    }

    public init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            self.text = ""
            return
        }

        self.text = String(data: data, encoding: .utf8) ?? ""
    }

    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let normalized = MarkdownUtilities.normalizedLineEndings(text)
        let data = normalized.data(using: .utf8) ?? Data()
        return FileWrapper(regularFileWithContents: data)
    }
}
