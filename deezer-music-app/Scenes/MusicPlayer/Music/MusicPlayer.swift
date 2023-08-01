//
//  MusicPlayer.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 27.07.2023.
//

import Foundation
import AVFoundation

protocol MusicPlayerProtocol {
    var currentPlay: AlbumDetailTrackListData? { get }
    var isPlaying: Bool { get }
    func play(url: URL)
    func pause()
    func toggleMusicStatus()
}

class MusicPlayer: MusicPlayerProtocol {
    
    static let shared = MusicPlayer()
    var currentPlay: AlbumDetailTrackListData?
    var isPlaying: Bool = false
    
    private init() { }
    
    func toggleMusicStatus() {
        if isPlaying {
            pause()
        } else {
            if let musicData = currentPlay {
                guard let previewURLString = musicData.preview, let previewURL = URL(string: previewURLString) else { return }
                play(url: previewURL)
            }
        }
    }
    
    func play(url: URL) {
        if let audioPlayer = audioPlayer {
            audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
        } else {
            audioPlayer = AVPlayer(url: url)
        }
        audioPlayer?.play()
        isPlaying = true
    }
    
    func pause() {
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        }
    }
}
