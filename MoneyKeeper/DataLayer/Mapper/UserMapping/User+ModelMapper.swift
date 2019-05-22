//
//  User+ModelMapper.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - UserMapperProtocol
protocol UserMapperProtocol {
    func userMapping(_ model: UserModel?) -> UserCoreDataModel?
    func userMapping(_ model: UserCoreDataModel?) -> UserModel?
}

// MARK: - UserMapperProtocol
extension ModelMapper: UserMapperProtocol {
    
    //Model -> CoreData
    func userMapping(_ model: UserModel?) -> UserCoreDataModel? {
        if let model = model {
            let userCoreDataModel = UserCoreDataModel()
            userCoreDataModel.deviceId = model.deviceId
            userCoreDataModel.userName = model.userName
            userCoreDataModel.cashFlows = NSSet(array: model.cashFlows?.compactMap({ self.cashFlowMapping($0) }) ?? [] )
            
            return userCoreDataModel
        }
        
        return nil
    }
    
    //CoreData -> Model
    func userMapping(_ model: UserCoreDataModel?) -> UserModel? {
        if let model = model, let deviceId = model.deviceId {
            let userModel = UserModel(deviceId: deviceId)
            userModel.userName = model.userName
            userModel.cashFlows = model.cashFlows?.compactMap({ (cashFlow) -> CashFlowModel? in
                if let cashFlowModel = cashFlow as? CashFlowCoreDataModel {
                    return self.cashFlowMapping(cashFlowModel)
                } else {
                    return nil
                }
            })
            
            return userModel
        }
        
        return nil
    }
}
