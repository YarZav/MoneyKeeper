//
//  String+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public extension String {

  /// String to double
  var toDouble: Double? {
    NumberFormatter().number(from: self)?.doubleValue
  }

  /// Add number to string
  mutating func addNumber(_ number: Int, pointSymbol: String?, maxFractionalNumbers: Int = 2) {
    if self == "0" {
      removeFirst()
    }

    if
      let pointSymbol = pointSymbol,
      let range = range(of: pointSymbol),
      String(self[range.upperBound...]).count == maxFractionalNumbers
    {
      return
    }
    append("\(number)")
  }

  /// Add decimal separator to Decimal string
  mutating func addDecimalSeparator(_ decimapSeparator: String) {
    if count == 0 {
      self = "0" + decimapSeparator
    } else if !contains(decimapSeparator) {
      append(decimapSeparator)
    }
  }

  /// Delete last charater from decimal separator
  mutating func deleteLastCharacter() {
    if self == "0" {
      return
    }
    removeLast()
    if count == 0 {
      self = "0"
    }
  }

}
