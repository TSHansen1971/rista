import AppKit
import RistaCore
import SwiftUI


private enum RistaMacApplicationIcon {
    static func install() {
        guard let iconURL = Bundle.module.url(forResource: "RistaAppIcon", withExtension: "icns"),
              let iconImage = NSImage(contentsOf: iconURL) else {
            return
        }

        NSApp.applicationIconImage = iconImage
    }
}


private enum RistaMacAboutIdentity {
    private static let fallbackVersion = "0.1"
    private static let fallbackBuild = "1"

    static var version: String {
        nonEmptyBundleValue(for: "CFBundleShortVersionString") ?? fallbackVersion
    }

    static var build: String {
        nonEmptyBundleValue(for: "CFBundleVersion") ?? fallbackBuild
    }

    static var versionLine: String {
        RistaL10n.format("about.versionFormat", version, build)
    }

    static var copyrightText: String { RistaL10n.string("about.copyright") }

    private static func nonEmptyBundleValue(for key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }

        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}

private enum RistaMacAboutPanel {
    static func show() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let copyrightText = NSAttributedString(
            string: RistaMacAboutIdentity.copyrightText,
            attributes: [
                .font: NSFont.systemFont(ofSize: NSFont.smallSystemFontSize),
                .paragraphStyle: paragraphStyle
            ]
        )

        var options: [NSApplication.AboutPanelOptionKey: Any] = [
            .applicationName: "Rísta",
            .applicationVersion: RistaMacAboutIdentity.versionLine,
            .credits: copyrightText
        ]

        if let iconURL = Bundle.module.url(forResource: "RistaAppIcon", withExtension: "icns"),
           let iconImage = NSImage(contentsOf: iconURL) {
            NSApp.applicationIconImage = iconImage
            options[.applicationIcon] = iconImage
        }

        NSApp.orderFrontStandardAboutPanel(options: options)
    }
}


@main
struct RistaMacApplication: App {
    @NSApplicationDelegateAdaptor(RistaMacApplicationDelegate.self) private var appDelegate

    var body: some Scene {
        DocumentGroup(newDocument: RistaDocument(text: RistaL10n.string("document.defaultText"))) { file in
            ContentView(document: file.$document)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button(RistaL10n.string("menu.aboutRista")) {
                    RistaMacAboutPanel.show()
                }
            }


            SidebarCommands()
            TextEditingCommands()
            TextFormattingCommands()
        }
    }
}

private final class RistaMacApplicationDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        RistaMacApplicationIcon.install()
        DispatchQueue.main.async {
            NSRunningApplication.current.activate(options: [.activateAllWindows])

            for window in NSApp.windows {
                window.makeKeyAndOrderFront(nil)
            }
        }
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        DispatchQueue.main.async {
            NSRunningApplication.current.activate(options: [.activateAllWindows])

            for window in sender.windows {
                window.makeKeyAndOrderFront(nil)
            }
        }

        return true
    }
}
