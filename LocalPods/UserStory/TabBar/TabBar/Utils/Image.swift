//  
//  Image.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import UIKit

extension UIImage {

  class func named(_ named: String) -> UIImage? {
    let bundle = Bundle.tabBarBundle
    let image = UIImage(named: named, in: bundle, compatibleWith: nil)
    assert(image != nil, "\(named) UIImage is nil")
    return image
  }

}
