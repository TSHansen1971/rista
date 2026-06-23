import AppKit
import RistaCore
import SwiftUI

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
