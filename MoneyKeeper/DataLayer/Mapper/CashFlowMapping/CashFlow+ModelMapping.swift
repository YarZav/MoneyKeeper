//
//  CashFlow+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowModelMapper
extension ModelMapper {
    
    //Model -> CoreData
    func cashFlowMapping(_ model: CashFlowModel?) -> CashFlowCoreDataModel? {
        guard let model = model else { return nil }
        
        let cashFlowCoreDataModel = CashFlowCoreDataModel()
        cashFlowCoreDataModel.identifier = model.id
        cashFlowCoreDataModel.price = (model.price as NSNumber).doubleValue
        cashFlowCoreDataModel.type = Int64(model.type.rawValue)
        cashFlowCoreDataModel.date = model.date
        cashFlowCoreDataModel.currencyCode = Int64(model.currencyCode.rawValue)
        cashFlowCoreDataModel.category = self.categoryMapping(model.categoryModel) ?? CategoryCoreDataModel()
        
        return cashFlowCoreDataModel
    }
    
    //[Model] -> [CoreData]
    func cashFlowMapping(_ models: [CashFlowModel]?) -> [CashFlowCoreDataModel]? {
        return models?.compactMap({ self.cashFlowMapping($0) })
    }
    
    //CoreData -> Model
    func cashFlowMapping(_ model: CashFlowCoreDataModel?) -> CashFlowModel? {
        guard let model = model, let type = CashFlowType(rawValue: Int(model.type)) else { return nil }
        
        let cashFlowModel = CashFlowModel(type: type)
        cashFlowModel.id = model.identifier
        cashFlowModel.price = Decimal(model.price)
        cashFlowModel.date = model.date
        cashFlowModel.currencyCode = CurrencyCode(rawValue: Int(model.currencyCode)) ?? .ruble
        cashFlowModel.categoryModel = self.categoryMapping(model.category) ?? CategoryModel(title: "", imageName: "")
        
        return cashFlowModel
    }
    
    //[CoreData] -> [Model]
    func cashFlowMapping(_ models: [CashFlowCoreDataModel]?) -> [CashFlowModel]? {
        return models?.compactMap({ self.cashFlowMapping($0) })
    }
}
