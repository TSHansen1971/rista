import Foundation

enum RistaL10n {
    static func string(_ key: String) -> String {
        preferredBundle.localizedString(forKey: key, value: nil, table: nil)
    }

    static func format(_ key: String, _ arguments: CVarArg...) -> String {
        String(format: string(key), locale: Locale.current, arguments: arguments)
    }

    private static var preferredBundle: Bundle {
        if let languageCode = preferredLanguageCode,
           let path = Bundle.module.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }

        if let path = Bundle.module.path(forResource: "en", ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }

        return Bundle.module
    }

    private static var preferredLanguageCode: String? {
        for language in Locale.preferredLanguages {
            let normalized = language.lowercased()

            if normalized == "nb" || normalized.hasPrefix("nb-") || normalized == "no" || normalized.hasPrefix("no-") {
                return "nb"
            }

            if normalized == "en" || normalized.hasPrefix("en-") {
                return "en"
            }
        }

        return nil
    }
}
