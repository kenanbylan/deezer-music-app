//
//  TabbarController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 12.07.2023.

import UIKit
import AVFAudio

class TabBarController: UITabBarController {
    
    var coordinator: TabbarCoordinator?
    var selectMusicData: AlbumDetailTrackListData?
    
    lazy var miniBar: MiniBarViewController = {
        let storyboard = UIStoryboard(name: Constants.System.Storyboard.miniBar , bundle: nil)
        guard let miniBar = storyboard.instantiateViewController(withIdentifier: Constants.System.Controller.miniBarController ) as? MiniBarViewController else { fatalError("MiniBarViewController not found in the storyboard.") }
        miniBar.view.translatesAutoresizingMaskIntoConstraints = false
        return miniBar
    }()

    lazy var musicDetailPage: MusicDetailViewController = {
        let musicDetailStoryboard = UIStoryboard(name: Constants.System.Storyboard.musicDetail , bundle: nil)
        guard let musicDetailPage = musicDetailStoryboard.instantiateViewController(withIdentifier: Constants.System.Controller.musicDetailViewController) as? MusicDetailViewController else {
            fatalError("Music detail not found in the storyboard.") }
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
        containerView.isHidden = true
        tabBar.tintColor = .red
        
        addChildView()
        setConstraints()
        miniBar.delegate = self
        coordinator = TabbarCoordinator(tabbarController: self, navigationController: UINavigationController())
        coordinator?.start()
    }
}

extension TabBarController: MiniBarDelegate {
    
    func miniBarDidTapButton() { containerView.isHidden.toggle() }
    
    func showMusicDetailPage(selectMusicData: AlbumDetailTrackListData) {
        coordinator?.showMusicDetail(musicDetail: selectMusicData)
    }
    
    func playMusic(musicData: AlbumDetailTrackListData) {
        containerView.isHidden = false
        miniBar.updateMusicWith(musicData: musicData)
    }
    
    func stopMusic() {  }
}

extension TabBarController: UITabBarControllerDelegate { }

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
