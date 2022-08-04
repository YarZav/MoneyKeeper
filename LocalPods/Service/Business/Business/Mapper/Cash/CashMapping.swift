//
//  CashMapper.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import DataBase

final class CashMapper {

  func map(_ cashModel: CashModel?) -> CashDBModel? {
    guard
      let cashModel = cashModel,
      let category = map(cashModel.category)
    else { return nil }

    let cashDBModel = CashDBModel()
    cashDBModel.identifier = cashModel.identifier
    cashDBModel.price = (cashModel.price as NSNumber).doubleValue
    cashDBModel.type = Int64(cashModel.type.rawValue)
    cashDBModel.date = cashModel.date
    cashDBModel.category = category
    return cashDBModel
  }
      
  func map(_ cashDBModel: CashDBModel?) -> CashModel? {
    guard
      let cashDBModel = cashDBModel,
      let type = CashType(rawValue: Int(cashDBModel.type)),
      let category = map(cashDBModel.category)
    else { return nil }

    return CashModel(
      identifier: cashDBModel.identifier,
      type: type,
      price: Decimal(cashDBModel.price),
      date: cashDBModel.date,
      category: category
    )
  }

  func map(_ cashCategoryDBModel: CashCategoryDBModel?) -> CashCategoryModel? {
    guard let cashCategoryDBModel = cashCategoryDBModel else { return nil }
    return CashCategoryModel(identifier: cashCategoryDBModel.identifier, title: cashCategoryDBModel.title)
  }

  func map(_ cashCategoryModel: CashCategoryModel?) -> CashCategoryDBModel? {
    guard let cashCategoryModel = cashCategoryModel else { return nil }
    let cashCategoryDBModel = CashCategoryDBModel()
    cashCategoryDBModel.identifier = cashCategoryModel.identifier
    cashCategoryDBModel.title = cashCategoryModel.title
    return cashCategoryDBModel
  }

}
