//
//  ArtistListViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

class ArtistListViewModel: ArtistListViewModelProtocol {
    
    var delegate: ArtistListViewModelDelegate?
    var coordinator: ArtistListCoordinator?
    var artistList: [ArtistResponse] = []
    
    private let artistListService: ArtistListServiceProtocol
    
    var genreId: Int?
    
    init(artistListService: ArtistListServiceProtocol) {
        self.artistListService = artistListService
    }
    
    func viewDidLoad() {
        guard let genreId = genreId else {
            return
        }
        getArtistList(genreId: genreId)
    }
    
    private func getArtistList(genreId: Int) {
        delegate?.handleViewModelOutput(.setLoading(true))
        print("Get artist ID: ", genreId)
         // TODO: İlgili genreId ile servis isteği yapın ve artistList'i güncelleyin
     }
   
    func getNumberOfArtist() -> Int {
        return artistList.count
    }
    
    func artistAt(_ index: Int) -> ArtistResponse? {
        guard index >= 0 && index < artistList.count else { return nil }
        return artistList[index]
    }
    
    func didSelectArtistAtIndex(_ index: Int) {
        guard let selectArtist = artistAt(index) else { return }
        //TODO: Handle Genre Selection
    }
}
