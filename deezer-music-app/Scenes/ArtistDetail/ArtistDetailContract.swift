//
//  ArtistDetailContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import Foundation

protocol ArtistDetailViewModelProtocol {
    var coordinator: ArtistDetailCoordinator? { get set }
    var delegate: ArtistDetailViewModelDelegate? { get set }
    var artistAlbumDetail: [AlbumTracksData] { get }
    
    func viewDidLoad()
    func artistAlbumAt(_ index: Int) -> AlbumTracksData?
    func didSelectArtistAlbum(_ index: Int)
    
}

enum ArtistDetailViewModelOutput {
    case showArtistDetail([AlbumTracksData])
    case showArtistAlbum([AlbumTracksData])
    case setLoading(Bool)
    case showTitle(String)
    case showTitleImage(URL?)
}

protocol ArtistDetailViewModelDelegate:AnyObject {
    func handleVieModelOutput(_ output: ArtistDetailViewModelOutput)
}
