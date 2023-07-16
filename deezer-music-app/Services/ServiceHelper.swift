//
//  ServiceHelper.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

struct Endpoints {
    static let baseURL = "https://api.deezer.com/"
}
