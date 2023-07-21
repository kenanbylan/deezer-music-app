//
//  FavoriteListViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.
//

import Foundation

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    var coordinator: FavoriteListCoordinator?
    var delegate: FavoriteListViewModelDelegate?
    
    var favoriteList: [AlbumDetailTrackListData] = []
    
    func viewDidLoad() {
        loadFavoriteList()
        delegate?.handleViewModelOutput(.setTitle("Favorite List"))
    }
    
    private func loadFavoriteList() {
        favoriteList = CoreDataManager.shared.fetchFavoriteTracks()
        delegate?.handleViewModelOutput(.showFavoriteList(favoriteList))
    }
    
    func numberOfFavorites() -> Int {
        return favoriteList.count
    }
    
    func favoriteAt(index: Int) -> AlbumDetailTrackListData? {
        guard index >= 0, index < favoriteList.count else { return nil }
        return favoriteList[index]
    }
    
    func didSelectFavoriteAt(index: Int) {
        guard index >= 0, index < favoriteList.count else { return }
        let selectedFavorite = favoriteList[index]
        print("Did Select favorite at:", selectedFavorite)
    }
    
    func removeFavoriteById(selectTrackId:Int) {
        CoreDataManager.shared.removeFavoriteTrack(id: selectTrackId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let succes):
                print("Favorite list:",favoriteList)
                print("Success removed: ",succes)
                self.favoriteList.remove(at: selectTrackId)
                delegate?.handleViewModelOutput(.successRemoved(true))

            case .failure(let error):
                print("Error: ",error)
                self.delegate?.handleViewModelOutput(.successRemoved(true))
            }
        }
    }
    
}
