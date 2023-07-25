//
//  FavoriteListViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 17.07.2023.

import Foundation

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    var coordinator: FavoriteListCoordinator?
    var delegate: FavoriteListViewModelDelegate?
    var miniBarDelegate: MiniBarDelegate?
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
        let favoriteMusic = favoriteAt(index: index)
        guard let favoriteMusic = favoriteMusic else { return }
        miniBarDelegate?.playMusic(musicData: favoriteMusic)
    }
    
    func removeFavoriteById(selectTrackId:Int) {
        CoreDataManager.shared.removeFavoriteTrack(id: selectTrackId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                if let index = self.favoriteList.firstIndex(where: { $0.trackId == selectTrackId }) {
                    self.favoriteList.remove(at: index)
                    delegate?.handleViewModelOutput(.successRemoved(true))
                }
            case .failure(_):
                self.delegate?.handleViewModelOutput(.successRemoved(true))
            }
        }
    }
}
