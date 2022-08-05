//
//  CashModel.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

public struct CashModel {

  /// identifier of model
  public let identifier: UUID

  /// Cash transaction type
  public let type: CashType

  /// Total price
  public let price: Decimal

  /// Date of transaction
  public let date: Date

  /// Category
  public var cashCategory: CashCategoryModel?

  // MARK: - Init

  public init(
    identifier: UUID,
    type: CashType,
    price: Decimal,
    date: Date,
    cashCategory: CashCategoryModel?
  ) {
    self.identifier = identifier
    self.type = type
    self.price = price
    self.date = date
    self.cashCategory = cashCategory
  }

  public init(
    type: CashType,
    price: Decimal
  ) {
    self.identifier = UUID()
    self.type = type
    self.price = price
    self.date = Date()
  }

}
