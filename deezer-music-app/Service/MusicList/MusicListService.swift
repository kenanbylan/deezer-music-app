//
//  MusicListService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation


class MusicListService : MusicListServiceProtocol {
    
    
    static let shared = MusicListService()

    
    func getGenres(complete: @escaping ((GenreData?, Error?) ->  Void )) {
        
        let url = MusicListEndpoints.genre
        
        Service.shared.request(type: GenreData.self, url: url , method: .get) { response in
            
            switch response {
            case .success(let genres):
                complete(genres,nil)
                
            case .failure(let error):
                complete(nil,error)
                print("ERROR: ", error.localizedDescription)
                
            }
        }
    }
    
    
    
//    func getSearchItems(text: String, page: Int, complete: @escaping ((Movie?, Error?) -> ())) {
//        NetworkManager.shared.request(type: Movie.self,
//                                      url: SearchEndpoint.search.path + "&query=\(text)&page=\(page)",
//                                      method: .get) { response in
//            switch response {
//            case .success(let data):
//                complete(data, nil)
//            case .failure(let error):
//                complete(nil, error)
//            }
//        }
//    }
    
    
}
