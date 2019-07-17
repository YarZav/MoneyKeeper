//
//  User+ModelMapper.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - UserModelMapper
extension ModelMapper {
    
    //Model -> CoreData
    func userMapping(_ model: UserModel?) -> UserCoreDataModel? {
        guard let model = model else { return nil }
        
        let userCoreDataModel = UserCoreDataModel()
        userCoreDataModel.deviceId = model.deviceId
        userCoreDataModel.userName = model.userName
        
        return userCoreDataModel
    }
    
    //CoreData -> Model
    func userMapping(_ model: UserCoreDataModel?) -> UserModel? {
        guard let model = model else { return nil }
        
        let userModel = UserModel(deviceId: model.deviceId)
        userModel.userName = model.userName
        
        return userModel
    }
}
