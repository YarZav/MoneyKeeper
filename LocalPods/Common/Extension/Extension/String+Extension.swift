//
//  String+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

public extension String {

  /// String to double
  func toDouble() -> Double? {
      return NumberFormatter().number(from: self)?.doubleValue
  }

    /// Localized string
  func localized(_ languageCode: String = "ru") -> String {
    if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
        if let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
    }
    
    return self
  }

  /// Create Decimal string from number
  mutating func addNumberToPriceString(_ number: Int, pointSymbol: String?) {
      if self == "0" {
          self.removeFirst()
      }
      
      if let pointSymbol = pointSymbol, let range = self.range(of: pointSymbol), String(self[range.upperBound...]).count == 2 {
          return
      }
      self.append("\(number)")
  }

  /// Add decimal separator to Decimal string
  mutating func addDecimalSeparator(_ decimapSeparator: String) {
      if self.count == 0 {
          self = "0" + decimapSeparator
      } else if !self.contains(decimapSeparator) {
          self.append(decimapSeparator)
      }
  }

  /// Delete last charater from decimal separator
  mutating func deleteLastCharacter() {
      if self == "0" { return }
      self.removeLast()
      if self.count == 0 { self = "0" }
  }

}
