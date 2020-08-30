//
//  CashFlow+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation

// MARK: - CashFlowModelMapper
class CashFlowModelMapper {
    func map(_ model: CashFlowModel?) -> CashFlowCoreDataModel? {
        guard let model = model else { return nil }
        guard let category = CategoryModelMapper().map(model.categoryModel) else { return nil }
        
        let cashFlowCoreDataModel = CashFlowCoreDataModel()
        cashFlowCoreDataModel.identifier = model.id
        cashFlowCoreDataModel.price = (model.price as NSNumber).doubleValue
        cashFlowCoreDataModel.type = Int64(model.type.rawValue)
        cashFlowCoreDataModel.date = model.date
        cashFlowCoreDataModel.currencyCode = Int64(model.currencyCode.rawValue)
        cashFlowCoreDataModel.category = category
        
        return cashFlowCoreDataModel
    }
        
    func map(_ model: CashFlowCoreDataModel?) -> CashFlowModel? {
        guard let model = model, let type = CashFlowType(rawValue: Int(model.type)) else { return nil }
        guard let category = CategoryModelMapper().map(model.category) else { return nil }
        
        let cashFlowModel = CashFlowModel(type: type)
        cashFlowModel.id = model.identifier
        cashFlowModel.price = Decimal(model.price)
        cashFlowModel.date = model.date
        cashFlowModel.currencyCode = CurrencyCode(rawValue: Int(model.currencyCode)) ?? .ruble
        cashFlowModel.categoryModel = category
        
        return cashFlowModel
    }
}
