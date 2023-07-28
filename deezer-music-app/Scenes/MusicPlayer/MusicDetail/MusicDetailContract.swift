//
//  MusicDetailContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 24.07.2023.
//

import UIKit

protocol MusicDetailViewModelDelegate: AnyObject {
    func setTitle(_ title: String)
    func setArtist(_ artist: String)
    func setAlbumImage(_ imageURL: URL?)
    func setAlbumTitle(_ albumTitle: String)
    func setPlayButtonImage(_ image: UIImage)
}
