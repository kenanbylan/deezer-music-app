//
//  ArtistListContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import Foundation

protocol ArtistListViewModelProtocol: AnyObject {
    var delegate: ArtistListViewModelDelegate? { get set }
    var artistList: [ArtistResponse] { get set }
    
    func viewDidLoad()

    func numberOfArtist() -> Int
    func artistAtIndex(_ index: Int) -> ArtistResponse?
    func didSelectArtistAtIndex(_ index: Int)
}

enum ArtistListViewModelOutput {
    case showArtistList([ArtistResponse])
    case setLoading(Bool)
}


protocol ArtistListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ArtistListViewModelOutput)
}
