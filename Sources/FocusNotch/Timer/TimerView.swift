import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: PomodoroViewModel
    @ObservedObject var loc = LanguageManager.shared
    @AppStorage("workDuration") private var workDuration: Double = 25

    var body: some View {
        HStack(spacing: 10) {
            Button(action: viewModel.reset) {
                Image(systemName: "stop.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Color.black)
                    .clipShape(Circle())
                    .opacity(viewModel.state == .idle ? 0.3 : 1)
            }
            .buttonStyle(.plain)

            Button(action: {
                if viewModel.isRunning {
                    viewModel.pause()
                } else {
                    viewModel.start()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.5, green: 0, blue: 0.5))
                    Circle()
                        .stroke(Color.white.opacity(viewModel.isRunning ? 0.6 : 0), lineWidth: 2)
                        .padding(2)
                    Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)

            ZStack {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Color(white: 0.15)

                        Color(red: 0.5, green: 0, blue: 0.5).opacity(0.4)
                            .frame(width: geo.size.width * viewModel.progress)

                        Rectangle()
                            .fill(Color(red: 0.5, green: 0, blue: 0.5))
                            .frame(width: 1)
                            .offset(x: geo.size.width * viewModel.progress)
                    }
                }

                if viewModel.isOnBreak {
                    HStack(spacing: 6) {
                        Text(tr("Coffee break"))
                            .foregroundColor(.orange.opacity(0.8))
                        Text(viewModel.formattedTime)
                            .foregroundColor(.white)
                            .monospacedDigit()
                    }
                    .font(.custom("Forza Thin", size: 22))
                } else {
                    Text(viewModel.formattedTime)
                        .font(.custom("Forza Thin", size: 22))
                        .foregroundColor(.white)
                        .monospacedDigit()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 32)
            .clipShape(RoundedRectangle(cornerRadius: 7))

            Button(action: {
                if !viewModel.isOnBreak {
                    viewModel.startBreak()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                    Circle()
                        .stroke(Color.white.opacity(viewModel.isOnBreak ? 0.6 : 0), lineWidth: 2)
                        .padding(2)
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, 2)
        .padding(.leading, 4)
    }
}
