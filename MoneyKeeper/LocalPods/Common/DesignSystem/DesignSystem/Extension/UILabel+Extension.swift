//
//  UILabel+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// Make label
    ///
    /// - Parameters:
    ///     - font: text font
    ///     - textColor: text color
    ///     - textAlignment: text alignment
    convenience init(font: UIFont, textColor: UIColor = UIColor.black, textAlignment: NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
