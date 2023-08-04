//
//  SceneDelegate.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 10.07.2023.

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var tabbarController = TabBarController()
    var isLogin: Bool = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        ChangeTheme.switchTheme(isDarkMode: isDarkModeEnabled)
        
        self.window = window
        
        let currentUser = Auth.auth().currentUser
        isLogin = currentUser != nil ? true : false
        
        if isLogin {
            let navigationController = UINavigationController()
            let coordinator = TabbarCoordinator(tabbarController: tabbarController, navigationController: navigationController)
            window.rootViewController = coordinator.tabbarController
            window.makeKeyAndVisible()
            coordinator.start()
            
        } else {
            let navigationController = UINavigationController()
            let tabbarCoordinator = TabbarCoordinator(tabbarController: tabbarController, navigationController: navigationController)
            tabbarController.viewControllers = tabbarCoordinator.setupViewControllers()
            
            navigationController.isNavigationBarHidden = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            let coordinator = LoginCoordinator(navigationController: navigationController,tabbarController: tabbarController)
            coordinator.start()
        }
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
