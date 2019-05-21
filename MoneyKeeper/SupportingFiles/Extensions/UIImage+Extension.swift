//
//  UIImage+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 21.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Color image with color
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
