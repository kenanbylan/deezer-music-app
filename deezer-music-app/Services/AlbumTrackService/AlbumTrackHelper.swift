//
//  AlbumTrackHelper.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

protocol AlbumTrackServiceProtocol {
    func getAlbumTrack(albumId: Int, completion:@escaping( (AlbumData?, Error?) -> Void))
}
