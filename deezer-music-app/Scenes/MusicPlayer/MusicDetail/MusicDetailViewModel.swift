//
//  MusicDetailViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit
import UIKit

final class MusicDetailViewModel {
    
    weak var delegate: MusicDetailViewModelDelegate?
    var selectPlayingMusic: AlbumDetailTrackListData?
    private var isPlaying: Bool = false
    
    var isMusicPlaying: Bool {
        return isPlaying
    }
    
    init(selectPlayingMusic: AlbumDetailTrackListData) {
        self.selectPlayingMusic = selectPlayingMusic
        isPlaying = MusicPlayer.shared.isPlaying
    }
    
    func viewDidLoad() {
        guard let selectPlayingMusic = selectPlayingMusic else { return }
        delegate?.setTitle(selectPlayingMusic.title ?? "")
        delegate?.setArtist(selectPlayingMusic.duration?.formatDuration() ?? "")
        delegate?.setAlbumImage(URL(string: selectPlayingMusic.albumImage ?? ""))
        delegate?.setAlbumTitle(selectPlayingMusic.albumName ?? "")
        updatePlayButtonImage()
    }
    
    func togglePlayback() {
        if isPlaying {
            MusicPlayer.shared.pause()
        } else {
            if let previewURLString = selectPlayingMusic?.preview, let previewURL = URL(string: previewURLString) {
                MusicPlayer.shared.play(url: previewURL)
            }
        }
        isPlaying.toggle()
        updatePlayButtonImage()
    }
    
    func shareTrack() {
        guard let trackLink = selectPlayingMusic?.link, let url = URL(string: trackLink) else { return }
        DeezerAlert.shared.showAlert(title: "Success Copy", message: "The link has been copied to thee clipboard successfully.") {
            print("Clicked cancel button")
        }
        UIPasteboard.general.url = url
    }
    
    private func updatePlayButtonImage() {
        let image = (isPlaying ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill")) ?? UIImage(named: "fav")
        guard let image = image else { return }
        delegate?.setPlayButtonImage(image)
    }
}
