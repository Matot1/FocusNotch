import SwiftUI
import ServiceManagement

enum SettingsTab: String, CaseIterable {
    case general = "General"
    case timer = "Timer"
    case notification = "Notification"
    case about = "About"

    var icon: String {
        switch self {
        case .general: return "gearshape"
        case .timer: return "timer"
        case .notification: return "bell"
        case .about: return "info.circle"
        }
    }
}

struct SettingsView: View {
    @ObservedObject var loc = LanguageManager.shared
    @State private var selectedTab: SettingsTab = .general

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                ForEach(SettingsTab.allCases, id: \.self) { tab in
                    Button(action: { selectedTab = tab }) {
                        HStack(spacing: 5) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 11))
                            Text(tr(tab.rawValue))
                                .font(.system(size: 11, weight: .medium))
                        }
                        .foregroundColor(selectedTab == tab ? .white : .white.opacity(0.5))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(selectedTab == tab ? Color.white.opacity(0.15) : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(selectedTab == tab ? Color.white.opacity(0.2) : Color.clear, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 4)

            Group {
                switch selectedTab {
                case .general:
                    GeneralSettingsView()
                case .timer:
                    TimerSettingsView()
                case .notification:
                    NotificationSettingsView()
                case .about:
                    AboutSettingsView()
                }
            }
        }
        .frame(width: 480, height: 360)
    }
}

// MARK: - General

struct GeneralSettingsView: View {
    @ObservedObject var loc = LanguageManager.shared
    @AppStorage("launchAtLogin") private var launchAtLogin = false

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "bolt.circle")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    Text(tr("Launch at Login"))
                        .font(.custom("Forza Thin", size: 12))
                        .foregroundColor(.white)

                    Spacer()

                    Toggle("", isOn: $launchAtLogin)
                        .toggleStyle(.switch)
                        .tint(.orange)
                        .onChange(of: launchAtLogin) { _, newValue in
                            if newValue {
                                try? SMAppService.mainApp.register()
                            } else {
                                try? SMAppService.mainApp.unregister()
                            }
                        }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                SettingRow(
                    icon: "music.note",
                    title: tr("Music Integration"),
                    description: tr("Spotify, Apple Music, Yandex Music")
                )

                HStack(spacing: 10) {
                    Image(systemName: "globe")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    Text(tr("Language"))
                        .font(.custom("Forza Thin", size: 12))
                        .foregroundColor(.white)

                    Spacer()

                    Picker("", selection: Binding(
                        get: { self.loc.language },
                        set: { self.loc.setLanguage($0) }
                    )) {
                        Text(tr("English")).tag("en")
                        Text(tr("Russian")).tag("ru")
                    }
                    .pickerStyle(.menu)
                    .tint(.orange)
                    .frame(width: 100)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Spacer(minLength: 0)

                Button(action: { NSApplication.shared.terminate(nil) }) {
                    HStack(spacing: 6) {
                        Image(systemName: "power")
                            .font(.system(size: 11))
                        Text(tr("Quit FocusNotch"))
                            .font(.custom("Forza Thin", size: 11))
                    }
                    .foregroundColor(.red.opacity(0.8))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.05))
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Timer

struct TimerSettingsView: View {
    @ObservedObject var loc = LanguageManager.shared
    @AppStorage("workDuration") private var workDuration: Double = 25
    @AppStorage("longBreakDuration") private var longBreakDuration: Double = 5
    @AppStorage("extendedBreakDuration") private var extendedBreakDuration: Double = 45
    @AppStorage("sessionsBeforeLongBreak") private var sessionsBeforeLongBreak: Double = 4
    @AppStorage("autoStartBreak") private var autoStartBreak = false

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                DurationRow(icon: "clock", label: tr("Focus Duration"), value: $workDuration, range: 5...60, suffix: tr("min"))
                DurationRow(icon: "cup.and.saucer.fill", label: tr("Coffee Break Time"), value: $longBreakDuration, range: 1...45, suffix: tr("min"))
                DurationRow(icon: "moon.zzz.fill", label: tr("Long Break"), value: $extendedBreakDuration, range: 15...90, suffix: tr("min"))

                HStack(spacing: 10) {
                    Image(systemName: "repeat")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    Text(tr("Sessions before long break"))
                        .font(.custom("Forza Thin", size: 12))
                        .foregroundColor(.white)
                    Spacer()
                    Stepper(value: $sessionsBeforeLongBreak, in: 1...10) {
                        Text("\(Int(sessionsBeforeLongBreak))")
                            .font(.custom("Forza Thin", size: 12))
                            .foregroundColor(.white)
                            .frame(width: 30, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack(spacing: 10) {
                    Image(systemName: "forward")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    Text(tr("Automatically start break after focus session"))
                        .font(.custom("Forza Thin", size: 12))
                        .foregroundColor(.white)

                    Spacer()

                    Toggle("", isOn: $autoStartBreak)
                        .toggleStyle(.switch)
                        .tint(.orange)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DurationRow: View {
    let icon: String
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let suffix: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 20)

                Text(label)
                    .font(.custom("Forza Thin", size: 12))
                    .foregroundColor(.white)
                Spacer()
                Text("\(Int(value)) \(suffix)")
                    .font(.custom("Forza Thin", size: 11))
                    .foregroundColor(.white.opacity(0.6))
            }
            Slider(value: $value, in: range, step: 1)
                .tint(.orange)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Notification

struct NotificationSettingsView: View {
    @ObservedObject var loc = LanguageManager.shared
    @AppStorage("soundAlerts") private var soundAlerts = true
    @AppStorage("fullConcentration") private var fullConcentration = false

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "bell")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(tr("Sound Alerts"))
                            .font(.custom("Forza Thin", size: 12))
                            .foregroundColor(.white)
                        Text(tr("Turn on/off sounds app"))
                            .font(.custom("Forza Thin", size: 10))
                            .foregroundColor(.white.opacity(0.4))
                    }

                    Spacer()

                    Toggle("", isOn: $soundAlerts)
                        .toggleStyle(.switch)
                        .tint(.orange)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack(spacing: 10) {
                    Image(systemName: "moon.zzz.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 20)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(tr("Full Concentration"))
                            .font(.custom("Forza Thin", size: 12))
                            .foregroundColor(.white)
                        Text(tr("Disable macOS notification when timer starting"))
                            .font(.custom("Forza Thin", size: 10))
                            .foregroundColor(.white.opacity(0.4))
                    }

                    Spacer()

                    Toggle("", isOn: $fullConcentration)
                        .toggleStyle(.switch)
                        .tint(.orange)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 12)
    }

}

// MARK: - About

struct AboutSettingsView: View {
    @ObservedObject var loc = LanguageManager.shared
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(tr("FocusNotch"))
                    .font(.custom("Forza Thin", size: 18))
                    .foregroundColor(.white)

                Text(tr("Version 1.0.0"))
                    .font(.custom("Forza Thin", size: 11))
                    .foregroundColor(.white.opacity(0.4))

                SettingRow(
                    icon: "person.circle",
                    title: tr("Developer"),
                    description: tr("FocusNotch Team")
                )

                SettingRow(
                    icon: "swift",
                    title: tr("Built with"),
                    description: tr("SwiftUI + AppKit")
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 12)
    }
}

// MARK: - Shared Components

struct SettingRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.custom("Forza Thin", size: 12))
                    .foregroundColor(.white)
                Text(description)
                    .font(.custom("Forza Thin", size: 10))
                    .foregroundColor(.white.opacity(0.4))
            }

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
