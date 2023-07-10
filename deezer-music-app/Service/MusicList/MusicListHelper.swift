//
//  MusicListManaager.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

protocol MusicListServiceProtocol {
    func getGenres(complete: @escaping((GenreData?, Error?)->()))
}


struct MusicListEndpoints {
    
    static let genre = "https://api.deezer.com/genre"
    static let artists = " https://api.deezer.com/genre/{genre_id}/artists"
    
}
