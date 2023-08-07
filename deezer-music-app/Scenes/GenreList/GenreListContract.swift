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
    var coordinator: GenreListCoordinator? { get set }
    
    func viewDidLoad()
    func genreAt(_ index: Int) -> GenreResponse?
    func didSelectGenreAt(_ index: Int)
}

enum GenreListViewModelOutput {
    case showGenreList([GenreResponse])
    case setLoading(Bool)
    case setTitle(String)
}

protocol GenreListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: GenreListViewModelOutput)
}
