//
//  CashFlowModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Foundation

// MARK: - CashFlowType
enum CashFlowType: Int {
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

// MARK: - CashFlowModel
class CashFlowModel {
  /// identifier of model
  var id: String = UUID().uuidString

  /// Cash flow transaction type
  var type: CashFlowType

  /// Total price
  var price: Decimal

  /// Date of transaction
  var date: Date

  /// Code of curency
  var currencyCode: CurrencyCode

  /// Category for cash flow
  var categoryModel: CategoryModel

  // Init
  init(type: CashFlowType) {
    self.type = type
    self.price = Decimal(0)
    self.date = Date()
    self.categoryModel = CategoryModel(title: "", imageName: "")
    self.currencyCode = .ruble
  }
}

// MARK: - Publics
extension CashFlowModel {
  public func getPriceAsString(numberStyle: NumberFormatter.Style) -> String {
    let numberFormatter = NumberFormatter.numberFormatter(numberStyle: numberStyle)
    let price = numberFormatter.string(from: self.price as NSNumber) ?? ""
    return price
  }
}
