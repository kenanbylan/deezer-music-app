//
//  Category.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

struct GenreData: Decodable {
    let data: [GenreResponse]?
}

struct GenreResponse: Decodable {
    let id: Int?
    let name: String?
    let pictureMedium: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case pictureMedium = "picture_medium"
    }
}

