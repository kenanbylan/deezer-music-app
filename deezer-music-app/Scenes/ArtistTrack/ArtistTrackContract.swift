//
//  ArtistTrackContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

protocol ArtistTrackViewModelProtocol {
    var delegate: ArtistTrackViewModelDelegate? { get set }
    var coordinator: ArtistTrackCoordinator? { get set }
    var artistAlbumData: AlbumData? { get }
    var artistAlbumDetail: [AlbumTracksData]? { get }
    func viewDidLoad()
    func numberOfTracks() -> Int
    func trackDataAt(index: Int) -> Track?
    func didSelectTrackAt(_ index: Int)
}

enum ArtistTrackViewModelOutput {
    case showArtistTrackList([Track])
    case setLoading(Bool)
    case showTitle(String)
    case didSelectTrack(Track)
}

protocol ArtistTrackViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ArtistTrackViewModelOutput)
}
