//
//  ArtistDetailHelper.swift
//  deezer-music-app
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

protocol ArtistDetailServiceProtocol {
    func getArtistData(tracklist: String, completion:@escaping( (AlbumTracksResponse?, Error?) -> Void))
    func getAlbumById(albumId: Int, completion:@escaping( (AlbumData?, Error?) -> Void) )
}

