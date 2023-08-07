//
//  FavoriteListContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.

import Foundation

protocol FavoriteListViewModelProtocol {
    var coordinator: FavoriteListCoordinator? { get set }
    var delegate: FavoriteListViewModelDelegate? { get set }
    var favoriteList: [AlbumDetailTrackListData] { get set }
    
    func viewDidLoad()
    func numberOfFavorites() -> Int
    func favoriteAt(index: Int) -> AlbumDetailTrackListData?
    func removeFavoriteById(selectTrackId:Int)
}

enum FavoriteListViewModelOutput {
    case showFavoriteList([AlbumDetailTrackListData])
    case setTitle(String)
    case successRemoved(Bool)
}

protocol FavoriteListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput)
}
