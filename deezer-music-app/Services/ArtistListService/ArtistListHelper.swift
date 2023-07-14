//
//  ArtistListHelper.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 13.07.2023.
//

import Foundation

protocol ArtistListServiceProtocol {
    func getArtistList(genreId: Int, completion:@escaping( (ArtistData?, Error?) -> Void))
}

struct ArtistListEndpoints {
    static let baseUrl = "https://api.deezer.com/genre/"
}
