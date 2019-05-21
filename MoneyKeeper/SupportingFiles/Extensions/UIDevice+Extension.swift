//
//  UIDevice+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /// Device types, iPhone 6 or 7 or 8 etc.
    enum DeviceType {
        case iPhone_5_5C_5S_SE
        case iPhone_6_7_8
        case iPhone_6_7_8_Plus
        case iPhone_X_Xs
        case iPhone_Xr_XsMax

        var isPhone: Bool {
            return [.iPhone_5_5C_5S_SE, .iPhone_6_7_8, .iPhone_6_7_8_Plus, .iPhone_X_Xs, .iPhone_Xr_XsMax].contains(self)
        }
    }
    
    /// Get current device type
    var deviceType: DeviceType? {
        switch UIDevice.current.userInterfaceIdiom {
            
        case .phone:
            let screenSize = UIScreen.main.bounds.size
            let height = max(screenSize.width, screenSize.height)
            
            switch height {
            case 568:
                return .iPhone_5_5C_5S_SE
            case 667:
                return .iPhone_6_7_8
            case 736:
                return .iPhone_6_7_8_Plus
            case 812:
                return .iPhone_X_Xs
            case 896:
                return .iPhone_Xr_XsMax
            default:
                return nil
            }
            
        case .unspecified, .pad, .tv, .carPlay:
            return nil
        }
    }
}
