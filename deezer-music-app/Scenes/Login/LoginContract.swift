//
//  LoginContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    var coordinator: LoginCoordinator? { get }
    
    var loginUser: User? { get set }

    func viewDidLoad()
    func loginControl(email: String, password: String)
}

enum LoginViewModelOutput {
    case setLoading(Bool)
    case setTitle(String)
    case loginError(String)
    case loginSuccess(Bool)
    
}

protocol LoginViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LoginViewModelOutput)
}
