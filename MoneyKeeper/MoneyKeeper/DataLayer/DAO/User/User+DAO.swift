//
//  UserDAO.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

protocol UserDAOProtocol {
    func createModel(callback: @escaping (Error?) -> Void)
    func getModel() -> UserCoreDataModel?
}

// MARK: - UserDAO
class UserDAO {
    private let categoryMapper: CategoryModelMapper
    private let coreDataManager: CoreDataManager

    init(categoryMapper: CategoryModelMapper, coreDataManager: CoreDataManager) {
        self.categoryMapper = categoryMapper
        self.coreDataManager = coreDataManager
    }
}
 
// MARK: - UserDAOProtocol
extension UserDAO: UserDAOProtocol {
    func createModel(callback: @escaping (Error?) -> Void) {
        guard let deviceId = getDeviceId() else {
            let error = CustomError(title: "UserDAO error", description: "Can not get Device ID", code: -1)
            callback(error)
            return
        }

        guard getModel() != nil else {
            let error = CustomError(title: "UserDAO error", description: "User core data model is created", code: -1)
            callback(error)
            return
        }
                
        let userCoreDataModel = UserCoreDataModel()
        userCoreDataModel.deviceId = deviceId
        
        let categoryCoreDataModels = CategoryModel.defaultModels().compactMap { categoryMapper.map($0) }
        userCoreDataModel.categories = NSSet(array: categoryCoreDataModels)
              
        coreDataManager.saveContext(callback: callback)
    }
    
    func getModel() -> UserCoreDataModel? {
        guard let deviceId = getDeviceId() else {
            return nil
        }

        let userCoreDataModels: [UserCoreDataModel]? = coreDataManager.getCoreDataModels(entityName: "User")
        let userCoreDataModel = userCoreDataModels?.first(where: { $0.deviceId == deviceId })

        return userCoreDataModel
    }

    private func getDeviceId() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
