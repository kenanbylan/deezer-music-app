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

    var artistAlbums: [AlbumResponse] { get set }
    var artistDetail: ArtistResponse? { get set }
    var selectedArtistHeaderImage: String? { get set }

    func viewDidLoad()
    func artistAlbumAt(_ index: Int) -> AlbumResponse?
    func didSelectArtistAlbum(_ index: Int)
}

enum ArtistDetailViewModelOutput {
    case showArtistAlbum([AlbumResponse])
    case setLoading(Bool)
    case showError(errorDescription: String)
    case showTitle(String)
}

protocol ArtistDetailViewModelDelegate:AnyObject {
    func handleVieModelOutput(_ output: ArtistDetailViewModelOutput)
}
