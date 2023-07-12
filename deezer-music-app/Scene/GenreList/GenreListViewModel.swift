//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

class GenreListViewModel: GenreListViewModelProtocol {
    
    var delegate: GenreListViewModelDelegate?
    var service: GenreListServiceProtocol
    var genreItems: [GenreResponse] = []

    init(service: GenreListServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        delegate?.handleViewModelOutput(.setLoading(true))
        getGenre()
    }
    
    private func getGenre() {
        service.getGenre { [weak self] genres, error in
            guard let self = self else { return }
            if let error = error {
                print("Error", error.localizedDescription)
            } else {
                delegate?.handleViewModelOutput(.setLoading(false))
                if let genre = genres {
                    self.delegate?.handleViewModelOutput(.showGenreList(genre.data))
                }
            }
        }
    }
    
    func didSelectGenre(_ genre: GenreResponse) {
        //TODO:
    }
}
