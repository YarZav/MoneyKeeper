//
//  CashFlowCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CashFlowCoreDataModel + DAO
extension DAO {
    
    /// Get all cash flow models for user
    public func getCashFlowCoreDataModels() -> [CashFlowCoreDataModel]? {
        let cashFlowCareDataModels = self.getUserCoreDataModel()?.cashFlows?.allObjects as? [CashFlowCoreDataModel]
        return cashFlowCareDataModels
    }
    
    /// Get cash flow model by identifier
    public func getCashFlowCoreDataModelBy(id: String) -> CashFlowCoreDataModel? {
        let coreDataModels = self.getCashFlowCoreDataModels()
        let coreDataModel = coreDataModels?.first { $0.identifier == id }
        return coreDataModel
    }
    
    /// Delete cash flow model by identifier
    public func deleteCashFlowCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void) {
        if let model = self.getCashFlowCoreDataModelBy(id: id) {
            self.dataManager.managedObjectContext.delete(model)
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Save new cash flow model
    public func saveCashFlowCoreDataModel(_ model: CashFlowCoreDataModel, callback: @escaping (Error?) -> Void) {
        let userCoreDataModel = self.getUserCoreDataModel()
        var cashFlowCoreDataModels = (userCoreDataModel?.cashFlows?.allObjects) as? [CashFlowCoreDataModel]
        
        if cashFlowCoreDataModels == nil {
            userCoreDataModel?.cashFlows = NSSet(array: [model])
        } else {
            cashFlowCoreDataModels?.append(model)
            userCoreDataModel?.cashFlows = NSSet(array: (cashFlowCoreDataModels ?? []))
        }
        
        self.save(callback: callback)
    }
}

