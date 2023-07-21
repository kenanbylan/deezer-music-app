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
    private let artistListService: ArtistListServiceProtocol!

    var artistList: [ArtistListResponse] = []
    var selectedGenre: GenreResponse?
    
    init(artistListService: ArtistListServiceProtocol) {
        self.artistListService = artistListService
    }
    
    func viewDidLoad() {
        delegate?.handleViewModelOutput(.setLoading(true))
        guard let genreId = selectedGenre?.id else { return }
        
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

private extension ArtistListViewModel {
    private func getArtistList(genreId: Int) {
        delegate?.handleViewModelOutput(.setLoading(true))
        artistListService.getArtistList(genreId: genreId) { [weak self] artists, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.handleViewModelOutput(.showError(errorDescription: error.localizedDescription))
            } else {
                self.artistList = artists?.data ?? []
                self.delegate?.handleViewModelOutput(.showArtistList(artistList))
            }
        }
        self.delegate?.handleViewModelOutput(.setLoading(false))
    }
}
