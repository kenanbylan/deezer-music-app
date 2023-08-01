//
//  Constants.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 13.07.2023.
//

import Foundation

enum Constants {
    enum System {
        enum Storyboard {
            static let genre = "GenreList"
            static let miniBar = "MiniBar"
            static let musicDetail = "MusicDetail"
            static let artistList = "ArtistList"
            static let artistDetail = "ArtistDetail"
            static let artistAlbum = "ArtistAlbum"
            static let favorites = "FavoriteList"
            static let settings = "Settings"
            static let login = "Login"
        }
        
        enum Controller {
            static let genreController = "GenreListViewController"
            static let miniBarController = "MiniBarViewController"
            static let artistListViewController = "ArtistListViewController"
            static let artistDetailViewController = "ArtistDetailViewController"
            static let artistAlbumViewController = "ArtistAlbumViewController"
            static let favoriteListViewController = "FavoriteListViewController"
            static let musicDetailViewController = "MusicDetailViewController"
            static let settingViewController = "SettingViewController"
            static let loginViewController = "LoginViewController"
        }
        
        enum CollectionViewCell {
            static let albumCollectionViewCell = "AlbumCollectionViewCell"
            static let favoriteCollectionViewCell = "FavoriteCollectionViewCell"
        }
    }
    
    enum Image {
        static let home = "home"
        static let favorites = "fav"
        static let settings = "setting"
        static let active_fav = "lover"
        static let inactive_fav = "heart"
    }
    
    enum Text {
        static let homeTitle = "Deezer App"
    }
}
