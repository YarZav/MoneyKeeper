//
//  Decimal+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 22/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

public extension Decimal {
    
  /// Decimal to string
  func toString(_ numberStyle: NumberFormatter.Style) -> String? {
    let numberFormatter = NumberFormatter.numberFormatter(numberStyle: .currency)
    let decimalString = numberFormatter.string(from: self as NSNumber)
    return decimalString
  }

}
