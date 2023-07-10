//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

class MusicListViewModel {
    
    static let shared = MusicListViewModel()
    
    var coordinator: MusicListCoordinator?
    
    let service = MusicListService.shared
    var genreItems: [Genre] = []
    
    
    //MARK: if data is true return succesCallback, if data is false errorCallback
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    //MARK: For alert
    var isLoadData :Bool = false
    
    func getGenres() {
        isLoadData = true
        service.getGenres { [weak self] genres, error in
            
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
                self?.isLoadData = false
            } else {
                if let genres = genres {
                    self?.genreItems = genres.data
                    self?.successCallback?() // if data is true will be return collectionView.reloadData()
                    
                    self?.isLoadData = false
                }
            }
        }
    }
    
    
}
