//
//  ArtistDetailHelper.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation


protocol ArtistDetailServiceProtocol {
    func getArtistData(tracklist: String, completion:@escaping( (AlbumTracksResponse?, Error?) -> Void))
}

struct ArtistDetailEndpoints {
//artist/4233013/top?limit=50
}
