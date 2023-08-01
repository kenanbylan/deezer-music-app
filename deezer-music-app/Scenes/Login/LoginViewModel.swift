//
//  LoginViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate?
    var coordinator: LoginCoordinator?
    
    func viewDidLoad() {
            print("Login view connected.")
    }
}
