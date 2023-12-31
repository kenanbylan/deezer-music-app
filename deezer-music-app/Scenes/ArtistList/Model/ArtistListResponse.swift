//  Artist.swift
//  deezer-music-app
//  Created by Kenan Baylan on 11.07.2023.

import Foundation

struct ArtistData: Decodable {
    let data: [ArtistListResponse]
}

struct ArtistListResponse: Decodable {
    let id: Int
    let name: String?
    let picture: String?
    let pictureSmall: URL?
    let pictureMedium: URL?
    let pictureBig: URL?
    let pictureXL: URL?
    let radio: Bool?
    let tracklist: String?
    let nbAlbum: Int?
    let nbFan: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, picture, radio, tracklist
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXL = "picture_xl"
        case nbAlbum = "nb_album"
        case nbFan = "nb_fan"
    }
}
