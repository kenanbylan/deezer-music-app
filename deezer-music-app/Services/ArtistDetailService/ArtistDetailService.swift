//
//  ArtistDetailService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

final class ArtistDetailService: ArtistDetailServiceProtocol {
    
    func getArtistData(tracklist: String, completion: @escaping ((AlbumTracksResponse?, Error?) -> Void)) {
        NetworkService.shared.request(type: AlbumTracksResponse.self, url: tracklist, method: .get) { response in
            switch response {
            case .success(let tracklistData):
                completion(tracklistData,nil)
            case .failure(let error):
                completion(nil,APIError.requestFailed(error))
            }
        }
    }
    
    func getAlbumById(albumId: Int, completion: @escaping ((AlbumData?, Error?) -> Void)) {
        let url = Endpoints.baseURL + "album/\(albumId)"
        
        NetworkService.shared.request(type: AlbumData.self, url: url , method: .get) { response in
            
            switch response {
            case .success(let albumData):
                completion(albumData,nil)
            case .failure(let error):
                completion(nil,APIError.requestFailed(error))
            }
        }
    }
}
