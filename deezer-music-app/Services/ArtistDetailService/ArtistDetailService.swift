//
//  ArtistDetailService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.
//

import Foundation

final class ArtistDetailService: ArtistDetailServiceProtocol {
    func getArtistData(tracklist: String, completion: @escaping ((AlbumTracksResponse?, Error?) -> Void)) {
        
        NetworkService.shared.request(type: AlbumTracksResponse.self, url: tracklist, method: .get) { response in
            
            switch response {
            case .success(let tracklistData):
                completion(tracklistData,nil)
            case .failure(let error):
                print("ERROR", error.localizedDescription)
                completion(nil,APIError.requestFailed(error))
            }
            
        }

    }
    
    
    
}
