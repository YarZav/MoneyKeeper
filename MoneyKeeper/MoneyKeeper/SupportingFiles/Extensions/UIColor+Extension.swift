//
//  UIColor+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Set color with for RGB wich color from 0.0 to 255.0
    static func rgb(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static var anthracite: UIColor {
        return #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1647058824, alpha: 1) //UIColor.rgb(red: 37, green: 37, blue: 42)
    }
    
    static var darkViolet: UIColor {
        return #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.3333333333, alpha: 1) //UIColor.rgb(red: 66, green: 66, blue: 85)
    }
    
    static var plainGray: UIColor {
        return #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.7529411765, alpha: 1) //UIColor.rgb(red: 176, green: 176, blue: 192)
    }
    
    static var blueGray: UIColor {
        return #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.6666666667, alpha: 1) //UIColor.rgb(red: 139, green: 139, blue: 170)
    }
    
    static var plainPurple: UIColor {
        return #colorLiteral(red: 0.3098039216, green: 0.1843137255, blue: 0.3803921569, alpha: 1) //UIColor.rgb(red: 79, green: 47, blue: 97)
    }
    
    static var lightBlue: UIColor {
        return #colorLiteral(red: 0.3960784314, green: 0.4274509804, blue: 0.662745098, alpha: 1) //UIColor.rgb(red: 101, green: 109, blue: 169)
    }
    
    static var darkRed: UIColor {
        return #colorLiteral(red: 0.5450980392, green: 0, blue: 0, alpha: 1) //UIColor.rgb(red: 139, green: 0, blue: 0)
    }
    
    static var darkGreen: UIColor {
        return #colorLiteral(red: 0, green: 0.3921568627, blue: 0, alpha: 1) //UIColor.rgb(red: 0, green: 100, blue: 0)
    }
}
