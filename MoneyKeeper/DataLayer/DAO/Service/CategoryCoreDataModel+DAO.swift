//
//  CategoryCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - UserCategoryCoreDataModel + Dao
extension DAO {
    
    /// Get all cageory models for user
    public func getCategoryCoreDataModels() -> [CategoryCoreDataModel]? {
        let userCoreDataModel = self.getUserCoreDataModel()
        let categoryCoreDataModels = userCoreDataModel?.categories?.allObjects as? [CategoryCoreDataModel]
        return categoryCoreDataModels
    }
    
    /// Get category model by identifier
    public func getCategoryCoreDataModelBy(id: String) -> CategoryCoreDataModel? {
        let categoryCoreDataModels = self.getCategoryCoreDataModels()
        let categoryCoreDataModel = categoryCoreDataModels?.first(where: { $0.identifier == id })
        return categoryCoreDataModel
    }
    
    /// Delete category model by identifier
    public func deleteCategoryCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void) {
        if let categoryCoreDataModel = self.getCategoryCoreDataModelBy(id: id) {
            self.dataManager.managedObjectContext.delete(categoryCoreDataModel)
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Save new category model
    public func saveCategoryCoreDataModel(_ model: CategoryCoreDataModel, callback: @escaping (Error?) -> Void) {
        let userCoreDataModel = self.getUserCoreDataModel()
        var categoryCoreDataModels = (userCoreDataModel?.categories?.allObjects) as? [CategoryCoreDataModel]
        
        if categoryCoreDataModels == nil {
            userCoreDataModel?.categories = NSSet(array: [model])
        } else {
            categoryCoreDataModels?.append(model)
            userCoreDataModel?.categories = NSSet(array: (categoryCoreDataModels ?? []))
        }
        
        self.save(callback: callback)
    }
}
