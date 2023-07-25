//
//  MusicDetailContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import Foundation

protocol MusicDetailViewModelProtocol {
    var coordinator: MusicDetailCoordinator? { get set }
    var delegate: MusicDetailViewModelDelegate? { get set }
    var selectPlayingMusic: AlbumDetailTrackListData? { get set }
    
    func viewDidLoad()
    func dissmis()
    func pauseMusic()
    func playMusic()
    func addFavorite()
}

enum MusicDetailViewModelOutput {
    case setTitle(String)
}

protocol MusicDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MusicDetailViewModelOutput)
}
