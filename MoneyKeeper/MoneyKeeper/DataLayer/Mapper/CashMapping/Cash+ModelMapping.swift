//
//  Cash+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation

// MARK: - CashModelMapper
class CashModelMapper {
  func map(_ model: CashModel?) -> CashCoreDataModel? {
    guard let model = model else { return nil }
    guard let category = CategoryModelMapper().map(model.categoryModel) else { return nil }
    let cashCoreDataModel = CashCoreDataModel()
    cashCoreDataModel.identifier = model.id
    cashCoreDataModel.price = (model.price as NSNumber).doubleValue
    cashCoreDataModel.type = Int64(model.type.rawValue)
    cashCoreDataModel.date = model.date
    cashCoreDataModel.currencyCode = Int64(model.currencyCode.rawValue)
    cashCoreDataModel.category = category
    return cashCoreDataModel
  }
      
  func map(_ model: CashCoreDataModel?) -> CashModel? {
    guard let model = model, let type = CashType(rawValue: Int(model.type)) else { return nil }
    guard let category = CategoryModelMapper().map(model.category) else { return nil }
    let cashModel = CashModel(type: type)
    cashModel.id = model.identifier
    cashModel.price = Decimal(model.price)
    cashModel.date = model.date
    cashModel.currencyCode = CurrencyCode(rawValue: Int(model.currencyCode)) ?? .ruble
    cashModel.categoryModel = category
    return cashModel
  }
}
