//
//  RegisterViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import Foundation


final class RegisterViewModel: RegisterViewModelProtocol {
    
    var delegate: RegisterViewModelDelegate?
    var coordinator: RegisterCoordinator?
    
    func viewDidLoad() {
        print("Login view connected.")
    }
    
    func registerControl(username: String, email: String, confirmPassword: String, password: String) {
        
    }
    
}
