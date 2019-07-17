//
//  UserCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - UserCoreDataModel + DAO
extension DAO {
    
    /// Create use account at app launch if needed
    public func createUserAccount(callback: @escaping (Error?) -> Void) {
        if self.getUserCoreDataModel() == nil {
            let userCoreDataModel = UserCoreDataModel()
            userCoreDataModel.deviceId = self.getDeviceId()
            
            let categoryCoreDataModels = CategoryModel.defaultModels().compactMap { self.mapper.categoryMapping($0) }
            userCoreDataModel.categories = NSSet(array: categoryCoreDataModels)
            
            let settingsManager = SettingsManager.sharedInstance
            userCoreDataModel.settings = self.mapper.settingsMapping(settingsManager.getDefaultSettings())
            
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Get user CoreData model
    public func getUserCoreDataModel() -> UserCoreDataModel? {
        let userCoreDataModels: [UserCoreDataModel]? = self.getCoreDataModels(entityName: "User")
        let userCoreDataModel = userCoreDataModels?.first(where: { $0.deviceId == self.getDeviceId() })
        
        let unusedUserCoreDataModels = userCoreDataModels?.filter({  $0.deviceId != self.getDeviceId() })
        unusedUserCoreDataModels?.forEach({
            self.dataManager.managedObjectContext.delete($0)
        })
        
        return userCoreDataModel
    }
    
    /// Delete user info
    public func deleteUserCoreDataInfo(callback: @escaping (Error?) -> Void) {
        let userCoreDataModel = self.getUserCoreDataModel()
        userCoreDataModel?.cashFlows = nil

        let categoryCoreDataModels = CategoryModel.defaultModels().compactMap { self.mapper.categoryMapping($0) }
        userCoreDataModel?.categories = NSSet(array: categoryCoreDataModels)

        userCoreDataModel?.cards = nil

        self.save(callback: callback)
    }
}
