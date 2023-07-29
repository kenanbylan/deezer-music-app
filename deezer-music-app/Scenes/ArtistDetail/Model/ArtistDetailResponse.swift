//
//  ArtistDetailResponse.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 29.07.2023.
//

import Foundation

struct AlbumResponseData: Decodable {
    let data: [AlbumResponse]?
}

struct AlbumResponse: Decodable, Hashable {
    
    let id: Int
    let title: String?
    let cover: String?
    let coverSmall: String?
    let coverMedium: String?
    let coverBig: String?
    let coverXl: String?
    let fans: Int?
    let releaseDate: String?
    let tracklist: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover, fans, tracklist
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
    }
}
