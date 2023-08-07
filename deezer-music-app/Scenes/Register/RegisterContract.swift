//
//  RegisterContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import Foundation


protocol RegisterViewModelProtocol: AnyObject {
    var delegate: RegisterViewModelDelegate? { get set }
    var coordinator: RegisterCoordinator? { get set }
    
    func viewDidLoad()
    func registerControl(username: String, email: String, confirmPassword: String, password: String)

}

enum RegisterViewModelOutput {
    case setLoading(Bool)
    case setTitle(String)
}

protocol RegisterViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: RegisterViewModelOutput)
}
