//
//  RegisterCoordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 1.08.2023.
//

import UIKit.UINavigationController

final class RegisterCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.register , bundle: nil)
        let registerViewController = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.registerViewController) as! RegisterViewController
        
        let viewModel = RegisterViewModel()
        viewModel.coordinator = self
        registerViewController.viewModel = viewModel
        navigationController.present(registerViewController, animated: true)
//        navigationController.pushViewController(registerViewController , animated: true)
    }
}

