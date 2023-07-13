//
//  MusicListService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation

final class GenreListService : GenreListServiceProtocol {
    
    func getGenre(completion: @escaping ((GenreData?, Error?) -> ())) {
        let url =  Endpoints.baseURL + "genre"
        
        NetworkService.shared.request(type: GenreData.self, url: url, method: .get) { response in
            switch response {
            case .success(let genres):
                completion(genres, nil)
            case .failure(let error):
                print("Error: ", error)
                completion(nil, APIError.requestFailed(error))
            }
        }
    }
}
