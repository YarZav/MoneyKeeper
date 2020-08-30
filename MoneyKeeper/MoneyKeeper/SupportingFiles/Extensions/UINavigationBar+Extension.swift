//
//  UINavigationBar+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /// Set transparent navigation bar
    func transparentNavigationBar(textColor: UIColor) {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]

    }
    
    /// Opaque navigation bar
    func opaque() {
        self.isTranslucent = false
        self.shadowImage = UIImage.imageWithColor(color: .darkGray)
    }
}
