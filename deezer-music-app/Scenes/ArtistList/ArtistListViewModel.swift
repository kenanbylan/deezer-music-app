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
    var artistList: [ArtistListResponse] = []
    private let artistListService: ArtistListServiceProtocol
    
    var selectedGenre: GenreResponse?
    
    init(artistListService: ArtistListServiceProtocol) {
        self.artistListService = artistListService
    }
    
    func viewDidLoad() {
        guard let genreId = selectedGenre?.id else {
            return
        }
        delegate?.handleViewModelOutput(.showTitle(selectedGenre?.name ?? "Nil"))
        getArtistList(genreId: genreId)
    }
    
    func artistAt(_ index: Int) -> ArtistListResponse? {
        guard index >= 0 && index < artistList.count else { return nil }
        return artistList[index]
    }
    
    func didSelectArtistAtIndex(_ index: Int) {
        guard let selectArtist = artistAt(index) else { return }
        
        //MARK: Next pages
        coordinator?.showArtistDetail(artist: selectArtist)
    }
}

// MARK: -GET RESPONSE

extension ArtistListViewModel {
    
    private func getArtistList(genreId: Int) {
        delegate?.handleViewModelOutput(.setLoading(true))
        artistListService.getArtistList(genreId: genreId) { [weak self] artists, error in
            guard let self = self else { return }
            if let error = error {
                print("Error:",error.localizedDescription)
                ///TODO: do alert handler.
            } else {
                self.artistList = artists?.data ?? []
                self.delegate?.handleViewModelOutput(.setLoading(false))
                self.delegate?.handleViewModelOutput(.showArtistList(artistList))
            }
        }
    }
}
