//
//  LoginViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    

}

extension LoginViewController: LoginViewModelDelegate {
    func handleViewModelOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .setTitle(_):
            break
        case .setLoading(_):
            break
        }
    }
}

