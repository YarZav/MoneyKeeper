//
//  NumberFormatter+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public extension NumberFormatter {

  /// Number formatter
  ///
  /// - Parameters:
  ///     - numberStyle: style of number
  ///     - currencySymbol: if needed
  ///     - maximumFractionDigits: max of fraction digit
  ///     - minimumFractionDigits: min of fraction digit
  static func numberFormatter(
    numberStyle: NumberFormatter.Style,
    currencySymbol: String? = nil,
    maximumFractionDigits: Int = 2,
    minimumFractionDigits: Int = 0
  ) -> NumberFormatter {
    let formatter = NumberFormatter()
    if let currencySymbol = currencySymbol {
        formatter.currencySymbol = currencySymbol
    }
    formatter.maximumFractionDigits = maximumFractionDigits
    formatter.minimumFractionDigits = minimumFractionDigits
    formatter.numberStyle = numberStyle
    return formatter
  }

}
