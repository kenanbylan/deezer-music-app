//
//  ArtistTrackContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

protocol ArtistAlbumViewModelProtocol {
    
    var delegate: ArtistAlbumViewModelDelegate? { get set }
    var coordinator: ArtistAlbumCoordinator? { get }
    
    var artistAlbumDetail: [AlbumDetailTrackListData]? { get }
    var selectAlbumId: Int? { get }
    var selectedAlbumName: String? { get }
    
    func viewDidLoad()
    func numberOfAlbum() -> Int
    func albumDataAt(index: Int) -> AlbumDetailTrackListData?
    func didSelectAlbumAt(index: Int)
    
    //MARK: Core Data func.
    func favoriteAlbum(selectTrackId: Int)
    func removeFavoriteAlbum(selectTrackId: Int)
}
enum ArtistAlbumViewModelOutput {
    case showArtistAlbumList([AlbumDetailTrackListData])
    case showTitle(String)
    case showError(errorDescription: String)
    case succesAddFavorite(Bool)
    case failureAddFavorite(Error)
}
protocol ArtistAlbumViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ArtistAlbumViewModelOutput)
}
