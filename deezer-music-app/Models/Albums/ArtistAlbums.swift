//
//  ArtistAlbums.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

//https://api.deezer.com/album/{albumId} apiye istek atıldığında karşılık verilecek.

struct AlbumData: Decodable {
    
    let id: Int?
    let title: String?
    let releaseDate: String?
    let tracklist: String?
    let cover: String?
    let tracks: TrackData?
    
    enum CodingKeys: String, CodingKey {
        case id, title, tracklist, cover, tracks
        case releaseDate = "release_date"
    }
}


struct TrackData: Decodable {
    let data: [Track]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([Track].self, forKey: .data)
    }
}

struct Track: Decodable {
    
    let id: Int?
    let title: String?
    let preview: String?
    let duration: Int?
    let cover: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, preview, duration, cover
    }
}

