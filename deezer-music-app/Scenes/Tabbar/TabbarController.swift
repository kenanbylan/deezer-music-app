//
//  TabbarController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.
//

import UIKit
import AVFAudio

class TabBarController: UITabBarController {
    
    var coordinator: TabbarCoordinator?
    
    lazy var miniBar: MiniBarViewController = {
        let storyboard = UIStoryboard(name: "MiniBar", bundle: nil) // Assuming your Storyboard file name is "Main"
        guard let miniBar = storyboard.instantiateViewController(withIdentifier: "MiniBarViewController") as? MiniBarViewController else {
            fatalError("MiniBarViewController not found in the storyboard.")
        }
        miniBar.view.translatesAutoresizingMaskIntoConstraints = false
        return miniBar
    }()
    
    
    lazy var musicDetailPage: MusicDetailViewController = {
        let musicDetailStoryboard = UIStoryboard(name: "MusicDetail", bundle: nil)
        guard let musicDetailPage = musicDetailStoryboard.instantiateViewController(withIdentifier: "MusicDetailViewController") as? MusicDetailViewController else {
            fatalError("MiniBarViewController not found in the storyboard.") }
        
        musicDetailPage.view.translatesAutoresizingMaskIntoConstraints = false
        return musicDetailPage
    }()
    
    
    
    var containerView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .red
        
        addChildView()
        
        setConstraints()
        miniBar.delegate = self
        
        coordinator = TabbarCoordinator(tabbarController: self, navigationController: UINavigationController())
        coordinator?.start()
    }
}

extension TabBarController: UITabBarControllerDelegate { }

extension TabBarController: MiniBarDelegate {
    
    func miniBarDidTapButton() {
        print("Clicked miniBarDidTapButton")
        containerView.isHidden.toggle()
    }
    
    func presentPlayerView() {
        
    }
    
    func playMusic(musicData: AlbumDetailTrackListData) {
        containerView.isHidden = false
        miniBar.updateMusicWith(musicData: musicData)
        
    }
}


extension TabBarController {
    
    func addChildView() {
        view.addSubview(containerView)
        addChild(miniBar)
        containerView.addSubview(miniBar.view)
        miniBar.didMove(toParent: self)
        
        if let childIndex = viewControllers?.firstIndex(of: miniBar) {
            viewControllers?.remove(at: childIndex)
        }
    }
    
    func setConstraints() {
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            miniBar.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            miniBar.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            miniBar.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            miniBar.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
