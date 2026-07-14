import SwiftUI
import Combine

class MusicViewModel: ObservableObject {
    @Published var currentTrack: Track = .placeholder
    @Published var isAuthorized: [MusicProvider: Bool] = [.spotify: false, .appleMusic: false, .yandexMusic: false]
    @Published var activeProvider: MusicProvider = .yandexMusic

    private var cancellables = Set<AnyCancellable>()

    private let spotifyService = SpotifyService()
    private let appleMusicService = AppleMusicService()
    private let yandexMusicService = YandexMusicService()

    init() {
        subscribe(to: spotifyService, provider: .spotify)
        subscribe(to: appleMusicService, provider: .appleMusic)
        subscribe(to: yandexMusicService, provider: .yandexMusic)
    }

    private func subscribe(to service: MusicServiceProtocol, provider: MusicProvider) {
        service.trackPublisher
            .compactMap { $0 }
            .sink { [weak self] track in
                if self?.activeProvider == provider {
                    self?.currentTrack = track
                }
            }
            .store(in: &cancellables)

        service.authPublisher
            .sink { [weak self] authorized in
                self?.isAuthorized[provider] = authorized
            }
            .store(in: &cancellables)
    }

    func playPause() {
        let t = currentTrack
        currentTrack = Track(
            id: t.id, title: t.title, artist: t.artist, album: t.album,
            albumArtURL: t.albumArtURL, duration: t.duration, progress: t.progress,
            isPlaying: !t.isPlaying, provider: t.provider
        )
        currentService?.playPause()
    }
    func nextTrack() { currentService?.nextTrack() }
    func previousTrack() { currentService?.previousTrack() }

    func authorize(provider: MusicProvider) {
        service(for: provider)?.authorize()
    }

    func switchProvider(_ provider: MusicProvider) {
        activeProvider = provider
        if let track = service(for: provider)?.currentTrack {
            currentTrack = track
        }
    }

    private var currentService: MusicServiceProtocol? {
        service(for: activeProvider)
    }

    private func service(for provider: MusicProvider) -> MusicServiceProtocol? {
        switch provider {
        case .spotify: return spotifyService
        case .appleMusic: return appleMusicService
        case .yandexMusic: return yandexMusicService
        }
    }
}
