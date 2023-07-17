//
//  FavoriteListViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import Foundation

final class FavoriteListViewModel: FavoriteListViewModelProtocol {

    var coordinator: FavoriteListCoordinator?
    var favoriteList: AlbumData?
    var delegate: FavoriteListViewModelDelegate?
    
    private let favoriteListService: FavoriteListService
    
    init(favoriteListService: FavoriteListService) {
        self.favoriteListService = favoriteListService
    }
    
    func viewDidLoad() {
        
    }
    
    func favoriteAt(_ index: Int) -> AlbumData? {

        return favoriteList
    }
    
    func didSelectFavoriteAt(_ index: Int) {
        
    }
    
    
    
    
}
