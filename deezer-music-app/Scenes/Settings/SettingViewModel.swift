//
//  SettingViewModel.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 29.07.2023.
//

import Foundation

final class SettingViewModel: SettingViewModelProtocol {
    
    var coordinator: SettingCoordinator?
    var delegate: SettingViewModelDelegate?
    let title = "Settings_title".localizable
    
    func viewDidload() {
        
    }
    
    func setThemeMode(isDarkMode: Bool) {
        ChangeTheme.switchTheme(isDarkMode: isDarkMode)
    }
    
    func setLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    
}
