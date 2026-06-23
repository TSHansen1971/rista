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

@main
struct RistaMacApplication: App {
    @NSApplicationDelegateAdaptor(RistaMacApplicationDelegate.self) private var appDelegate

    var body: some Scene {
        DocumentGroup(newDocument: RistaDocument()) { file in
            ContentView(document: file.$document)
        }
        .commands {
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
