//
//  LoginContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    var coordinator: LoginCoordinator? { get set }
    
    func viewDidLoad()
}

enum LoginViewModelOutput {
    case setLoading(Bool)
    case setTitle(String)
}

protocol LoginViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LoginViewModelOutput)
}
