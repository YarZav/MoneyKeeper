//
//  UIColor+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static var anthracite: UIColor {
        return UIColor.rgb(red: 37, green: 37, blue: 42)
    }
    
    static var darkViolet: UIColor {
        return UIColor.rgb(red: 66, green: 66, blue: 85)
    }
    
    static var darkVioletTranslucent: UIColor {
        return UIColor.rgb(red: 66, green: 66, blue: 85, alpha: 0.5)
    }
    
    static var plainGray: UIColor {
        return UIColor.rgb(red: 176, green: 176, blue: 192)
    }
    
    static var blueGray: UIColor {
        return UIColor.rgb(red: 139, green: 139, blue: 170)
    }
    
    static var plainPurple: UIColor {
        return UIColor.rgb(red: 79, green: 47, blue: 97)
    }
    
    static var lightBlue: UIColor {
        return UIColor.rgb(red: 101, green: 109, blue: 169)
    }
}
