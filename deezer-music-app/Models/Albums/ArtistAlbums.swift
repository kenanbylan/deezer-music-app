//
//  ArtistAlbums.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation
//https://api.deezer.com/album/{albumId} when a request is sent to the API, it will be responded to.

struct AlbumResponseData: Decodable {
    let data: [AlbumResponse]?
}

struct AlbumResponse: Decodable, Hashable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall: String
    let coverMedium: String
    let coverBig: String
    let coverXl: String
    let fans: Int
    let releaseDate: String
    let tracklist: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover, fans, tracklist
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
    }
}


//MARK: Album detail's
struct AlbumDetailResponse: Decodable {
    let id: Int
    let title: String?
    let cover: String?
    let coverSmall: String?
    let coverMedium: String?
    let coverBig: String?
    let coverXl: String?
    let fans: Int?
    let tracks: TrackDetailDataResponse?
    let artist: ArtistResponse?
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover, fans,artist,tracks
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
    }
    
}

struct TrackDetailDataResponse: Decodable {
    let data: [TrackDetailResponse]?
}

struct TrackDetailResponse: Decodable {
    let id: Int
    let title: String?
    let duration: Int?
    let preview: String?
    let link: String?
}

//Add to favorites appear to the model.
struct AlbumDetailTrackListData: Hashable {
    
    let id: Double
    var isFavorite: Bool = false //will might delete.
    let albumImage: String?
    let trackId: Int?
    let title: String?
    let duration: Int?
    let preview: String?
    let artistName: String?
    let albumName: String?
    let link: String?
}
