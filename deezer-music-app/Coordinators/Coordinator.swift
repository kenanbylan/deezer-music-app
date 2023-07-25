//
//  Coordinator.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var rootViewController: UIViewController? { get set }
    func start()
}

extension Coordinator {
    func popBack(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
