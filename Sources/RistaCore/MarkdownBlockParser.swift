import Foundation

public enum MarkdownBlock: Equatable {
    case heading(level: Int, text: String)
    case paragraph(String)
    case unorderedList([String])
    case orderedList([String])
    case quote(String)
    case code(String)
    case horizontalRule
}

public enum MarkdownBlockParser {
    public static func parse(_ input: String) -> [MarkdownBlock] {
        let normalized = MarkdownUtilities.normalizedLineEndings(input)
        let lines = normalized.components(separatedBy: "\n")
        var blocks: [MarkdownBlock] = []
        var paragraph: [String] = []
        var index = 0

        func flushParagraph() {
            guard !paragraph.isEmpty else { return }
            blocks.append(.paragraph(paragraph.joined(separator: " ")))
            paragraph.removeAll()
        }

        while index < lines.count {
            let line = lines[index]
            let trimmed = line.trimmingCharacters(in: .whitespaces)

            if trimmed.isEmpty {
                flushParagraph()
                index += 1
                continue
            }

            if trimmed.hasPrefix("```") {
                flushParagraph()
                index += 1
                var codeLines: [String] = []
                while index < lines.count {
                    let candidate = lines[index]
                    if candidate.trimmingCharacters(in: .whitespaces).hasPrefix("```") {
                        index += 1
                        break
                    }
                    codeLines.append(candidate)
                    index += 1
                }
                blocks.append(.code(codeLines.joined(separator: "\n")))
                continue
            }

            if isHorizontalRule(trimmed) {
                flushParagraph()
                blocks.append(.horizontalRule)
                index += 1
                continue
            }

            if let heading = parseHeading(trimmed) {
                flushParagraph()
                blocks.append(heading)
                index += 1
                continue
            }

            if let firstQuote = parseQuote(trimmed) {
                flushParagraph()
                var quotes = [firstQuote]
                index += 1
                while index < lines.count, let next = parseQuote(lines[index].trimmingCharacters(in: .whitespaces)) {
                    quotes.append(next)
                    index += 1
                }
                blocks.append(.quote(quotes.joined(separator: "\n")))
                continue
            }

            if let firstItem = parseUnorderedItem(trimmed) {
                flushParagraph()
                var items = [firstItem]
                index += 1
                while index < lines.count, let next = parseUnorderedItem(lines[index].trimmingCharacters(in: .whitespaces)) {
                    items.append(next)
                    index += 1
                }
                blocks.append(.unorderedList(items))
                continue
            }

            if let firstItem = parseOrderedItem(trimmed) {
                flushParagraph()
                var items = [firstItem]
                index += 1
                while index < lines.count, let next = parseOrderedItem(lines[index].trimmingCharacters(in: .whitespaces)) {
                    items.append(next)
                    index += 1
                }
                blocks.append(.orderedList(items))
                continue
            }

            paragraph.append(trimmed)
            index += 1
        }

        flushParagraph()
        return blocks
    }

    private static func parseHeading(_ line: String) -> MarkdownBlock? {
        var level = 0
        for character in line {
            if character == "#" {
                level += 1
            } else {
                break
            }
        }

        guard (1...6).contains(level) else { return nil }
        let marker = String(repeating: "#", count: level)
        guard line.hasPrefix(marker + " ") else { return nil }
        let text = String(line.dropFirst(level + 1))
        return .heading(level: level, text: text)
    }

    private static func parseQuote(_ line: String) -> String? {
        guard line.hasPrefix(">") else { return nil }
        return String(line.dropFirst()).trimmingCharacters(in: .whitespaces)
    }

    private static func parseUnorderedItem(_ line: String) -> String? {
        for marker in ["- ", "* ", "+ "] where line.hasPrefix(marker) {
            return String(line.dropFirst(marker.count))
        }
        return nil
    }

    private static func parseOrderedItem(_ line: String) -> String? {
        var digitCount = 0
        for character in line {
            if character.isNumber {
                digitCount += 1
            } else {
                break
            }
        }

        guard digitCount > 0 else { return nil }
        let remainder = line.dropFirst(digitCount)
        guard remainder.hasPrefix(". ") else { return nil }
        return String(remainder.dropFirst(2))
    }

    private static func isHorizontalRule(_ line: String) -> Bool {
        let compact = line.replacingOccurrences(of: " ", with: "")
        guard compact.count >= 3 else { return false }
        return Set(compact) == ["-"] || Set(compact) == ["*"] || Set(compact) == ["_"]
    }
}
