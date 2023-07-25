//
//  MusicListManaager.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

protocol GenreListServiceProtocol {
    func getGenre(completion: @escaping((GenreData?, Error?)->()))
}
