//
//  ArtistDetailService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

final class ArtistDetailService: ArtistDetailServiceProtocol {
    
    func getArtistDetail(artistId: Int, completion: @escaping ((ArtistResponse?, Error?) -> Void)) {
        let url = Endpoints.baseURL + "artist" + "/\(artistId)"
        NetworkService.shared.request(type: ArtistResponse.self, url:url, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,APIError.requestFailed(error))
            }
        }
    }
    
    func getAlbumById(artistId: Int, completion: @escaping ((AlbumResponseData?, Error?) -> Void)) {
        let url = Endpoints.baseURL + "artist" + "/\(artistId)" + "/albums"
        NetworkService.shared.request(type: AlbumResponseData.self, url: url , method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                print("Error", error)
                completion(nil,APIError.requestFailed(error))
            }
        }
    }
}
