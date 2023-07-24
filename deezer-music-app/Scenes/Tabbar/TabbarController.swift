//
//  TabbarController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: TabbarCoordinator?
    
    // lazy var miniPlayer: MiniBarPlayer = loadPlayerBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        coordinator = TabbarCoordinator(tabbarController: self, navigationController: UINavigationController())
        coordinator?.start()
        
      //  setConstraints()
        
    }
//
//    func setConstraints() {
//
//        view.addSubview(miniPlayer)
//        miniPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: miniPlayer.trailingAnchor).isActive = true
//        miniPlayer.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true // Değiştirildi
//        miniPlayer.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//
//    func loadPlayerBar() -> MiniBarPlayer {
//        let miniBarPlayer = MiniBarPlayer()
//        miniBarPlayer.translatesAutoresizingMaskIntoConstraints = false
//        miniBarPlayer.delegate = self
//        return miniBarPlayer
//    }
}

extension TabBarController: UITabBarControllerDelegate { }


extension TabBarController: MiniBarPlayerDelegate {
    
    func trackPauseTap() {
        //TODO: -
    }
}

