//
//  CategoryCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

protocol CategoryDAOProtocol {
    func getCategoryCoreDataModels() -> [CategoryCoreDataModel]?
    func deleteCategoryCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void)
    func saveCategoryCoreDataModel(_ model: CategoryCoreDataModel, callback: @escaping (Error?) -> Void)
}

// MARK: - CategoryDAO
class CategoryDAO {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension CategoryDAO: CategoryDAOProtocol {
    /// Get all cageory models for user
    public func getCategoryCoreDataModels() -> [CategoryCoreDataModel]? {
//        let categoryCoreDataModels = userCoreDataModel.categories?.allObjects as? [CategoryCoreDataModel]
//        return categoryCoreDataModels
      return nil
    }
        
    /// Delete category model by identifier
    public func deleteCategoryCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void) {
//        let categoryCoreDataModels = getCategoryCoreDataModels(for: userCoreDataModel)
//        if let categoryCoreDataModel = categoryCoreDataModels?.first(where: { $0.identifier == id }) {
//            coreDataManager.managedObjectContext.delete(categoryCoreDataModel)
//            coreDataManager.saveContext(callback: callback)
//        } else {
//            callback(nil)
//        }
    }
    
    /// Save new category model
    public func saveCategoryCoreDataModel(_ model: CategoryCoreDataModel, callback: @escaping (Error?) -> Void) {
//        var categoryCoreDataModels = (userCoreDataModel.categories?.allObjects) as? [CategoryCoreDataModel]
//
//        if categoryCoreDataModels == nil {
//            userCoreDataModel.categories = NSSet(array: [model])
//        } else {
//            categoryCoreDataModels?.append(model)
//            userCoreDataModel.categories = NSSet(array: (categoryCoreDataModels ?? []))
//        }
//
//        coreDataManager.saveContext(callback: callback)
    }
}
