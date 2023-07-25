//
//  AlbumTrack.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

struct AlbumTracksResponse: Decodable {
    let data: [AlbumTracksData]?
}

struct AlbumTracksData: Decodable, Hashable {
    
    let id: Int?
    let readable: Bool?
    let title, titleShort: String?
    let link: String?
    let duration, rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let album: ArtistAlbums?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case album, type
    }
}

struct ArtistAlbums: Decodable, Hashable {
    let id: Int?
    let title: String?
    let cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let tracklist: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
}
