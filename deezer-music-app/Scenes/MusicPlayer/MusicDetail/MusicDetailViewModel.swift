//
//  MusicDetailViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit

final class MusicDetailViewModel: MusicDetailViewModelProtocol {
    
    var delegate: MusicDetailViewModelDelegate?
    var selectPlayingMusic: AlbumDetailTrackListData?
    private var isPlaying: Bool = false
    
    var isMusicPlaying: Bool {
        return isPlaying
        
    }
    
    init(selectPlayingMusic: AlbumDetailTrackListData) {
        self.selectPlayingMusic = selectPlayingMusic
    }
    
    func viewDidLoad() {
        guard let selectPlayingMusic = selectPlayingMusic else { return }
        delegate?.handleViewModelOutput(.setTitle(title: selectPlayingMusic.title ?? ""))
        delegate?.handleViewModelOutput(.setArtist(artist: selectPlayingMusic.artistName ?? ""))
        delegate?.handleViewModelOutput(.setAlbumImage(imageURL: URL(string: selectPlayingMusic.albumImage ?? "")))
        delegate?.handleViewModelOutput(.setAlbumTitle(albumTitle: selectPlayingMusic.albumName ?? "" ))
        updatePlayButtonImage()
    }
    
    func togglePlayback() {
        isPlaying.toggle()
        updatePlayButtonImage()
    }
    
    func addFavorite() {
        // TODO: Implement adding the music to favorites logic
    }
    
    func shareTrack() {
        guard let trackLink = selectPlayingMusic?.link, let url = URL(string: trackLink) else {
            return
        }
        UIPasteboard.general.url = url
        delegate?.handleViewModelOutput(.showLinkCopiedMessage(true))
    }
    
    private func updatePlayButtonImage() {
        let image = (isPlaying ? UIImage(systemName: "pause") : UIImage(systemName: "play")) ?? UIImage(named: "fav")
        guard let image = image else { return }
        delegate?.handleViewModelOutput(.setPlayButtonImage(image: image))
    }
}

