//
//  ArtistDetailHelper.swift
//  deezer-music-app
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

protocol ArtistDetailServiceProtocol {
    func getArtistDetail(artistId: Int, completion:@escaping((ArtistResponse?, Error?) -> Void) )
    func getAlbumById(artistId: Int, completion:@escaping( (AlbumResponseData?, Error?) -> Void) )
}
