//
//  ArtistListViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

class ArtistListViewModel: ArtistListViewModelProtocol {
    
    var delegate: ArtistListViewModelDelegate?
    var artistList: [ArtistResponse] = []
    
    private let artistListService: ArtistListServiceProtocol

    init(artistListService: ArtistListServiceProtocol) {
        self.artistListService = artistListService
    }

    
    func viewDidLoad() {
        delegate?.handleViewModelOutput(.setLoading(true))
        //getArtistList(genre: <#T##GenreResponse#>)
    }
    
    
    private func getArtistList(genre:GenreResponse) {
        //TODO: .
    }
    
    func numberOfArtist() -> Int {
        return artistList.count
    }
    
    func artistAtIndex(_ index: Int) -> ArtistResponse? {
        guard index >= 0 && index < artistList.count else {
            return nil
        }
        return artistList[index]
    }
    
    func didSelectArtistAtIndex(_ index: Int) {
        guard let selectArtist = artistAtIndex(index) else { return }
    
        //TODO: Handle Genre Selection
    }
}
