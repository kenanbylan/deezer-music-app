//
//  FavoriteListContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.


import Foundation

protocol FavoriteListViewModelProtocol {
    var coordinator: FavoriteListCoordinator? { get set }
    var favoriteList: AlbumData? { get }
    var delegate: FavoriteListViewModelDelegate? { get set }
    
    func viewDidLoad()
    func favoriteAt(_ index: Int) -> AlbumData?
    func didSelectFavoriteAt(_ index: Int)
}

enum FavoriteListViewModelOutput {
    case showFavoriteList([AlbumData])
    case setLoading(Bool)
    case setTitle(String)
}

protocol FavoriteListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput)
}
