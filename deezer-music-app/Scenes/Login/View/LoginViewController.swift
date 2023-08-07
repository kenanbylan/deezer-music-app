//
//  LoginViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: Delegate
    var viewModel: LoginViewModelProtocol! { didSet { viewModel.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let password = passwordTextfield.text , let email = emailTextfield.text else { return }
        viewModel.delegate?.handleViewModelOutput(.buttonInactive(false))
        viewModel.loginControl(email: email, password: password)
       
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewModel.coordinator?.showRegister()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func handleViewModelOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .setTitle(_):
            break
        case .setLoading(_):
            break
        case .loginSuccess(_):
            //showAlertMessage(title: "Success", message: "Success login")
            viewModel.coordinator?.showTabbar()
        case .loginError(let error):
            DeezerAlert.shared.showAlert(title: "Error"  , message: error, onCancelTapped: nil)
            
        case .buttonInactive(_
        ):
            break
//            loginButton.isEnabled = status
        }
    }
}
