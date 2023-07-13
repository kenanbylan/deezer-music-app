//
//  ArtistListService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 13.07.2023.
//

import Foundation

final class ArtistListService: ArtistListServiceProtocol {
    
    func getArtistList(genreId: Int, completion: @escaping ((ArtistData?, Error?) -> Void)) {
        let url = ArtistListEndpoints.baseUrl + "\(genreId)/artists"
        
        NetworkService.shared.request(type: ArtistData.self, url: url, method: .get) { response in
            switch response {
            case .success(let artists):
                completion(artists,nil)
                
            case .failure(let error):
                print("Error: ", error)
                completion(nil,APIError.requestFailed(error))
            }
        }
    }
}
