//
//  ChangeTheme.swift
//  deezer-music-app
//
//  Created by Kenan Baylan on 31.07.2023.
//

import UIKit

struct ChangeTheme {
    static func switchTheme(isDarkMode: Bool) {
        if isDarkMode {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
}
