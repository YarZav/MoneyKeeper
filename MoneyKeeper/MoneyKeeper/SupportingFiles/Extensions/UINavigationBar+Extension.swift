//
//  UINavigationBar+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
  func transparentNavigationBar(textColor: UIColor) {
    setBackgroundImage(UIImage(), for: .default)
    shadowImage = UIImage()
    isTranslucent = true
    titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]

  }

  func opaque() {
    isTranslucent = false
    self.shadowImage = UIImage.imageWithColor(color: .darkGray)
  }
}
