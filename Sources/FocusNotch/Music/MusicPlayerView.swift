import SwiftUI

struct MusicPlayerView: View {
    @ObservedObject var viewModel: MusicViewModel
    @ObservedObject var loc = LanguageManager.shared
    @AppStorage("theme") private var theme: String = "dark"

    var body: some View {
        HStack(spacing: 12) {
            albumArt

            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.currentTrack.artist)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(ThemeColors.text(theme))
                    .lineLimit(1)

                Text(viewModel.currentTrack.title)
                    .font(.system(size: 10))
                    .foregroundColor(ThemeColors.secondaryText(theme))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 14) {
                Button(action: viewModel.previousTrack) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 14))
                        .foregroundColor(ThemeColors.secondaryText(theme))
                }
                .buttonStyle(.plain)

                Button(action: viewModel.playPause) {
                    Image(systemName: viewModel.currentTrack.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(ThemeColors.text(theme))
                }
                .buttonStyle(.plain)

                Button(action: viewModel.nextTrack) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 14))
                        .foregroundColor(ThemeColors.secondaryText(theme))
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    private var albumArt: some View {
        if let url = viewModel.currentTrack.albumArtURL,
           let nsImage = NSImage(contentsOf: url)
        {
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        } else {
            RoundedRectangle(cornerRadius: 6)
                .fill(ThemeColors.quaternaryText(theme))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: "music.note")
                        .font(.system(size: 16))
                        .foregroundColor(ThemeColors.tertiaryText(theme))
                )
        }
    }
}
