//
//  CashModel.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Foundation

public enum CashType: Int {

  // Расходы
  case outcome

  // Доходы
  case income

}

public struct CashModel {

  /// identifier of model
  public let identifier: String

  /// Cash transaction type
  public let type: CashType

  /// Total price
  public let price: Decimal

  /// Date of transaction
  public let date: Date

}
