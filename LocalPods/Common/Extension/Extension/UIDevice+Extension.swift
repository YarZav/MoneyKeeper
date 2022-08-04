//
//  UIDevice+Extension.swift
//  Core
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

public enum DeviceType {
  case iPhone_5S_SE
  case iPhone_6_7_8
  case iPhone_6_7_8_Plus
  case iPhone_X_Xs_11Pro
  case iPhone_Xr_XsMax_11_11ProMax
}

public extension UIDevice {

  /// Get current device type
  var type: DeviceType? {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        let screenSize = UIScreen.main.bounds.size
        let height = max(screenSize.width, screenSize.height)
        switch height {
        case 568:
          return .iPhone_5S_SE
        case 667:
          return .iPhone_6_7_8
        case 736:
          return .iPhone_6_7_8_Plus
        case 812:
          return .iPhone_X_Xs_11Pro
        case 896:
          return .iPhone_Xr_XsMax_11_11ProMax
        default:
          return nil
        }
    default:
      return nil
    }
  }

}
