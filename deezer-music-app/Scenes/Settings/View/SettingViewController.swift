//
//  SettingViewController.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 29.07.2023.

import UIKit
import FirebaseAuth

final class SettingViewController: UIViewController {
    
    @IBOutlet weak var changeThemeSwitch: UISwitch!
    @IBOutlet weak var currentUser: UILabel!
    
    var viewModel: SettingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        setupSwitch()
        
        if let userEmail = Auth.auth().currentUser?.email {
            currentUser.text = userEmail
        }
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        let isDarkMode = sender.isOn
        animateThemeChange(isDarkMode: isDarkMode)
        viewModel.setThemeMode(isDarkMode: isDarkMode)
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkModeEnabled")
    }
    
    @IBAction func changeLanguageTapped(_ sender: Any) {
        showLanguageSelectionActionSheet()
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        print("Logout button tapped")
        do {
            try Auth.auth().signOut()
            viewModel.coordinator?.navigateToLogin()
            //            viewModel.coordinator?.popBack(animated: true)
        } catch {
            print("error: ", error.localizedDescription)
        }
    }
    
    func setupSwitch() {
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        changeThemeSwitch.isOn = isDarkModeEnabled
    }
    
    func changeAppLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let alertController = UIAlertController(title: "Restart Required", message: "Please restart the app for the language change to take effect.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Setting UI

extension SettingViewController {
    
    func showLanguageSelectionActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let turkishAction = UIAlertAction(title: "Türkçe", style: .default) { _ in
            self.changeAppLanguage(to: "tr")
        }
        
        let englishAction = UIAlertAction(title: "English", style: .default) { _ in
            self.changeAppLanguage(to: "en") }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(turkishAction)
        actionSheet.addAction(englishAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func animateThemeChange(isDarkMode: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.0
        }) { _ in
            ChangeTheme.switchTheme(isDarkMode: isDarkMode)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.alpha = 1.0
            })
        }
    }
    
    func setupUI() {
        self.navigationItem.title = "Settings_title".localizable
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}

extension SettingViewController: SettingViewModelDelegate {
    func handleOutput(_ output: SettingViewModelOutput) {
        switch output {
        case .setTitle(let title):
            self.navigationItem.title = title
        }
    }
}
