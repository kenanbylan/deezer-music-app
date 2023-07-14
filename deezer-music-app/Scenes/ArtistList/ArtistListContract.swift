//
//  ArtistListContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import Foundation

protocol ArtistListViewModelProtocol: AnyObject {
    
    var coordinator: ArtistListCoordinator? { get set }
    var delegate: ArtistListViewModelDelegate? { get set }
    var artistList: [ArtistResponse] { get }
    
    func viewDidLoad()

    func artistAt(_ index: Int) -> ArtistResponse?
    func didSelectArtistAtIndex(_ index: Int)
}

enum ArtistListViewModelOutput {
    case showArtistList([ArtistResponse])
    case setLoading(Bool)
    case showTitle(String)
}

protocol ArtistListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ArtistListViewModelOutput)
}
