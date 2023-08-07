//
//  RegisterViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Propertie's
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel: RegisterViewModelProtocol! { didSet { viewModel.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func handleViewModelOutput(_ output: RegisterViewModelOutput) {
        switch output {
        case .setTitle(_):
            break
        case .setLoading(_):
            break
        }
    }
}
