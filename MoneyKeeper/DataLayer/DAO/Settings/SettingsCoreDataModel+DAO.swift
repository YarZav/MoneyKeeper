//
//  SettingsCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - SettingsCoreDataModel + DAO
extension DAO {
    
    /// Update language
    public func updateSettingLanguageCode(_ code: Int64, callback: @escaping (Error?) -> Void) {
        if let userCoreDataModel = self.getUserCoreDataModel() {
            userCoreDataModel.settings?.languageCode = code
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Update currency
    public func updateSettingCurrencyCode(_ code: Int64, callback: @escaping (Error?) -> Void) {
        if let userCoreDataModel = self.getUserCoreDataModel() {
            userCoreDataModel.settings?.currencyCode = code
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Update local push enabled
    public func enabledLocalPush(_ enabled: Bool, callback: @escaping (Error?) -> Void) {
        if let userCoreDataModel = self.getUserCoreDataModel() {
            userCoreDataModel.settings?.push = enabled
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Get settings model
    public func getSettingsCoreDataModel() -> SettingsCoreDataModel? {
        let userCoreDataModel = self.getUserCoreDataModel()
        return userCoreDataModel?.settings
    }
}
