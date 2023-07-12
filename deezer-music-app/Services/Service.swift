//
//  ServiceManager.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation
import Alamofire

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    
    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethod,
                             completion: @escaping((Result<T, APIError>)->())) {
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", method: method).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
                
            case .failure(let error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, APIError>)->())) {
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
            
        } catch {
            completion(.failure(.decodingFailed(error)))
        }
    }
    
}
