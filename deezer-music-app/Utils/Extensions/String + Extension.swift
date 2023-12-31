//  String + Extension.swift
//  deezer-music-app
//  Created by Kenan Baylan on 20.07.2023.
//

import UIKit

extension String {
    
    func formatReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let releaseDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: releaseDate)
        } else {
            return self //MARK: - If the fails we return the original date.
        }
    }
    
    //For Localizable string.
    var localizable: String {
        return NSLocalizedString(self, comment: self)
    }
}
