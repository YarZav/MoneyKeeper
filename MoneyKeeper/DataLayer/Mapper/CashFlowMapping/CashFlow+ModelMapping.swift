//
//  CashFlow+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowMapperProtocol
protocol CashFlowMapperProtocol {
    func cashFlowMapping(_ model: CashFlowModel?) -> CashFlowCoreDataModel?
    func cashFlowMapping(_ model: CashFlowCoreDataModel?) -> CashFlowModel?
}

// MARK: - CashFlowMapperProtocol
extension ModelMapper: CashFlowMapperProtocol {
    
    //Model -> CoreData
    func cashFlowMapping(_ model: CashFlowModel?) -> CashFlowCoreDataModel? {
        if let model = model {
            let cashFlowCoreDataModel = CashFlowCoreDataModel()
            cashFlowCoreDataModel.identifier = model.id
            cashFlowCoreDataModel.price = model.price.doubleValue
            cashFlowCoreDataModel.type = Int64(model.type.rawValue)
            cashFlowCoreDataModel.date = model.date
            cashFlowCoreDataModel.service = self.serviceMapping(model.serviceModel) ?? ServiceCoreDataModel()
            
            return cashFlowCoreDataModel
        }
        
        return nil
    }
    
    //CoreData -> Model
    func cashFlowMapping(_ model: CashFlowCoreDataModel?) -> CashFlowModel? {
        if let model = model, let type = CashFlowType(rawValue: Int(model.type)) {
            let cashFlowModel = CashFlowModel(type: type)
            cashFlowModel.id = model.identifier
            cashFlowModel.price = NSNumber(value: model.price)
            cashFlowModel.date = model.date
            cashFlowModel.serviceModel = self.serviceMapping(model.service) ?? ServiceModel(title: "", imageName: "")
            
            return cashFlowModel
        }
        
        return nil
    }
}
