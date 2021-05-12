//
//  CashModel.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Foundation

// MARK: - CashType
public enum CashType: Int {
  // Расходы
  case outcome

  // Доходы
  case income
}

// MARK: - CashModel
public struct CashModel {
  /// identifier of model
  public var identifier: String

  /// Cash transaction type
  public var type: CashType

  /// Total price
  public var price: Decimal

  /// Date of transaction
  public var date: Date
}

//// MARK: - Publics
//extension CashModel {
//  public func getPriceAsString(numberStyle: NumberFormatter.Style) -> String {
//    let numberFormatter = NumberFormatter.numberFormatter(numberStyle: numberStyle)
//    let price = numberFormatter.string(from: self.price as NSNumber) ?? ""
//    return price
//  }
//}
