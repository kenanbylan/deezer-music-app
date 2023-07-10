//
//  ServiceHelper.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.
//

import Foundation


enum ErrorMessage: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class ServiceHelper {
    
    static let shared = ServiceHelper()
    
    let baseUrl = ""
    
    
}
