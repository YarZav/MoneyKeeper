//
//  CashMapper.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public final class CashMapper {

  public init() { }

}

// MARK: - Public

public extension CashMapper {

  func map(_ cashModel: CashModel?) -> CashDBModel? {
    guard
      let cashModel = cashModel,
      let categoryType = cashModel.categoryType
    else { return nil }

    let cashDBModel = CashDBModel()
    cashDBModel.identifier = cashModel.identifier
    cashDBModel.price = (cashModel.price as NSNumber).doubleValue
    cashDBModel.type = cashModel.type.rawValue
    cashDBModel.date = cashModel.date
    cashDBModel.categoryType = categoryType.rawValue
    return cashDBModel
  }

  func map(_ cashDBModel: CashDBModel?) -> CashModel? {
    guard
      let cashDBModel = cashDBModel,
      let type = CashType(rawValue: cashDBModel.type),
      let categoryType = CashCategoryType(rawValue: cashDBModel.categoryType)
    else { return nil }

    return CashModel(
      identifier: cashDBModel.identifier,
      type: type,
      price: Decimal(cashDBModel.price),
      date: cashDBModel.date,
      categoryType: categoryType
    )
  }

}
