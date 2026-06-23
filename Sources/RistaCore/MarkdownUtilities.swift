import Foundation

public enum MarkdownUtilities {
    public static func normalizedLineEndings(_ input: String) -> String {
        input
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }
}
