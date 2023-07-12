//
//  GenreListContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 11.07.2023.
//

import Foundation

protocol GenreListViewModelProtocol: AnyObject {
    
    var delegate: GenreListViewModelDelegate? { get set }
    var genreItems: [GenreResponse] { get set}
    var artistCoordinator: ArtistListCoordinator? { get set }
    
    func viewDidLoad()
    func numberOfGenres() -> Int
    func genreAtIndex(_ index: Int) -> GenreResponse?
    func didSelectGenreAtIndex(_ index: Int)
}

enum GenreListViewModelOutput {
    case showGenreList([GenreResponse])
    case setLoading(Bool)
}

protocol GenreListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: GenreListViewModelOutput)
}
