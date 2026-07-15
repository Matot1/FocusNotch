import Cocoa
import SwiftUI
import Combine

class SettingsWindowController: NSWindowController {
    private var cancellables = Set<AnyCancellable>()
    @AppStorage("theme") private var theme: String = "dark"

    static func create() -> SettingsWindowController {
        let theme = UserDefaults.standard.string(forKey: "theme") ?? "dark"

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 360),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = tr("Settings")
        window.isReleasedWhenClosed = false
        window.backgroundColor = ThemeColors.nsBackground(theme)
        window.center()

        let hostingView = NSHostingView(rootView: SettingsView())
        hostingView.wantsLayer = true
        hostingView.layer?.backgroundColor = ThemeColors.nsBackground(theme).cgColor
        window.contentView = hostingView

        let controller = SettingsWindowController(window: window)
        controller.observeLanguageChanges()
        controller.observeThemeChanges(hostingView: hostingView, window: window)
        return controller
    }

    private func observeLanguageChanges() {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                self?.window?.title = tr("Settings")
            }
            .store(in: &cancellables)
    }

    private func observeThemeChanges(hostingView: NSHostingView<SettingsView>, window: NSWindow) {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { _ in
                let theme = UserDefaults.standard.string(forKey: "theme") ?? "dark"
                window.backgroundColor = ThemeColors.nsBackground(theme)
                hostingView.layer?.backgroundColor = ThemeColors.nsBackground(theme).cgColor
            }
            .store(in: &cancellables)
    }

    func show() {
        let theme = UserDefaults.standard.string(forKey: "theme") ?? "dark"
        window?.backgroundColor = ThemeColors.nsBackground(theme)
        window?.contentView?.layer?.backgroundColor = ThemeColors.nsBackground(theme).cgColor
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
