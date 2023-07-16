//
//  AlbumTrackService.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 15.07.2023.

import Foundation

final class AlbumTrackService: AlbumTrackServiceProtocol {
    //    example id: 68851461
    func getAlbumTrack(albumId: Int, completion: @escaping ((AlbumData?, Error?) -> Void)) {
        let url =  Endpoints.baseURL + "/album/\(albumId)"
        
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
