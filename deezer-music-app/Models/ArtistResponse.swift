//
//  ArtistResponse.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 14.07.2023.
//

import Foundation


/*

 ArtistDetail sayfası açılmadan önce(herhangi bir sanatçıya tıklanıldığında) aşağıdaki response içerisinden tracklist alınıp yeni bir istek atılmalı. Örnek bir tracklist url'i aşağıda verilmiştir:

 https://api.deezer.com/artist/4233013/top?limit=50
 4233013 ->  artist list id ardından. Sanatçıya ait albümler gelir.
 
 Bu listeden çekilen veriler ile albüm fotografları ve albüm isimleri CollectionViewda gösterilecektir. Struct: ArtistAlbumsData

 BU kısım yapıldıktan sonra ArtistListAlbum data içerisinde tıklanan albumun id'si alınıp :
 https://api.deezer.com/album/albumId bu adrese istek atılacaktır burada ise Artistin o albumundeki şarkılar listelenecektir.
 
 
 
 */


// will might deleted
struct ArtistResponse: Decodable {
    let id: Int
    let name: String?
    let link, share, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let nbAlbum, nbFan: Int?
    let radio: Bool?
    let tracklist: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case nbAlbum = "nb_album"
        case nbFan = "nb_fan"
        case radio, tracklist, type
    }
}
