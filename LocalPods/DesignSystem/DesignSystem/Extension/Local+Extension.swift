//
//  Local+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 04.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

extension Locale {

  /// Get current currency symbol base on device language
  static func getCurrencySymbol() -> String? {
    Locale.current.currencySymbol
  }

}
