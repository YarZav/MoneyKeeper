//
//  CashModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Foundation

// MARK: - CashType
enum CashType: Int {
  case outcome = 0        // Расходы
  case income  = 1        // Доходы

  var title: String {
    switch self {
    case .outcome: return "Consumption"
    case .income:  return "Income"
    }
  }

  var color: UIColor {
    switch self {
    case .outcome: return .darkRed
    case .income:  return .darkGreen
    }
  }
}

// MARK: - CashModel
final class CashModel {
  /// identifier of model
  var id: String = UUID().uuidString

  /// Cash transaction type
  var type: CashType

  /// Total price
  var price: Decimal

  /// Date of transaction
  var date: Date

  /// Category for cash
  var categoryModel: CategoryModel

  // Init
  init(type: CashType) {
    self.type = type
    self.price = Decimal(0)
    self.date = Date()
    self.categoryModel = CategoryModel(title: "", imageName: "")
  }
}

// MARK: - Publics
extension CashModel {
  public func getPriceAsString(numberStyle: NumberFormatter.Style) -> String {
    let numberFormatter = NumberFormatter.numberFormatter(numberStyle: numberStyle)
    let price = numberFormatter.string(from: self.price as NSNumber) ?? ""
    return price
  }
}
