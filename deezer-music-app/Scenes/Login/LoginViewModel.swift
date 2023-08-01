//
//  LoginViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.

import Foundation
import FirebaseAuth

final class LoginViewModel: LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate?
    var coordinator: LoginCoordinator?
    
    var loginUser: User?

    func viewDidLoad() {
        print("Login view connected.")
    }
    
    func loginControl(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let authResult = authResult {
                loginUser?.email = authResult.user.email ?? "test"
                loginUser?.id = authResult.user.uid
                print("login user ", loginUser)
            } else {
                guard let error = error else { return }
                delegate?.handleViewModelOutput(.loginError(error.localizedDescription))
            }
        }
    }
}
