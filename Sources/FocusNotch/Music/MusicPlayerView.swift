import SwiftUI

struct MusicPlayerView: View {
    @ObservedObject var viewModel: MusicViewModel
    @ObservedObject var loc = LanguageManager.shared

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.currentTrack.displayTitle)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))

            HStack(spacing: 20) {
                Button(action: viewModel.previousTrack) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
                .buttonStyle(.plain)

                Button(action: viewModel.playPause) {
                    Image(systemName: viewModel.currentTrack.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)

                Button(action: viewModel.nextTrack) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
