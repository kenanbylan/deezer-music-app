//
//  MusicDetailContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit

protocol MusicDetailViewModelProtocol {
    
    var delegate: MusicDetailViewModelDelegate? { get set }
    var selectPlayingMusic: AlbumDetailTrackListData? { get }
    var isMusicPlaying: Bool { get }
    func viewDidLoad()
    func togglePlayback()
    func addFavorite()
    func shareTrack()
}

enum MusicDetailViewModelOutput {
    case setTitle(title: String)
    case setArtist(artist: String)
    case setAlbumTitle(albumTitle: String)
    case setAlbumImage(imageURL: URL?)
    case setPlayButtonImage(image: UIImage)
    case showLinkCopiedMessage(Bool)
}

protocol MusicDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MusicDetailViewModelOutput)
}
