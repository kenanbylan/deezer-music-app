//
//  SettingContract.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 29.07.2023.
//

import Foundation

protocol SettingViewModelProtocol {
    var coordinator: SettingCoordinator? { get }
    var delegate: SettingViewModelDelegate? { get set }
    
    func viewDidload()
    func setThemeMode(isDarkMode: Bool)
    func setLanguage(to languageCode: String)
}

enum SettingViewModelOutput {
    case setTitle(String)
}

protocol SettingViewModelDelegate: AnyObject {
    func handleOutput(_ output: SettingViewModelOutput)
}


