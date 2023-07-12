//
//  MusicListViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

class GenreListViewModel: GenreListViewModelProtocol {
    
    var delegate: GenreListViewModelDelegate?
    private let service: GenreListServiceProtocol
    internal var genreItems: [GenreResponse] = []
    var artistCoordinator: ArtistListCoordinator?
   
    init(service: GenreListServiceProtocol, artistCoordinator: ArtistListCoordinator) {
        self.service = service
        self.artistCoordinator = artistCoordinator
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
                self.genreItems = genres?.data ?? []
                self.delegate?.handleViewModelOutput(.setLoading(false))
                self.delegate?.handleViewModelOutput(.showGenreList(self.genreItems))
            }
        }
    }
    
    func numberOfGenres() -> Int {
        return genreItems.count
    }
    
    func genreAtIndex(_ index: Int) -> GenreResponse? {
        guard index >= 0 && index < genreItems.count else {
            return nil
        }
        return genreItems[index]
    }
    
    func didSelectGenreAtIndex(_ index: Int) {
        guard let genre = genreAtIndex(index) else {
            return
        }
        
        // TODO: Handle genre selection
        //artistCoordinator?.start()
        
    }
}
