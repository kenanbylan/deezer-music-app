//
//  TabbarController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        coordinator = TabbarCoordinator(tabbarController: self, navigationController: UINavigationController())
        coordinator?.start()
    }
    
    
}

extension TabBarController: UITabBarControllerDelegate {
    
}
