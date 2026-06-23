import RistaCore
import SwiftUI

@main
struct RistaMacApplication: App {
    var body: some Scene {
        DocumentGroup(newDocument: RistaDocument()) { file in
            ContentView(document: file.$document)
        }
        .commands {
            SidebarCommands()
        }
    }
}
