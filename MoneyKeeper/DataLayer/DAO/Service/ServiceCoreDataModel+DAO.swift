//
//  ServiceCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - UserServiceCoreDataProtocol
protocol UserServiceCoreDataProtocol {
    func getUserServiceCoreDataModels() -> [ServiceCoreDataModel]?
    func getUserServiceCoreDataModelBy(id: String) -> ServiceCoreDataModel?
}

// MARK: - UserServiceCoreDataProtocol
extension DAO: UserServiceCoreDataProtocol {
    
    func getUserServiceCoreDataModels() -> [ServiceCoreDataModel]? {
        if let userCoreDataModel = self.getUserCoreDataModel() {
            let serviceCoreDataModels = userCoreDataModel.services?.compactMap({ $0 as? ServiceCoreDataModel })
            return serviceCoreDataModels
        }
        
        return nil
    }
    
    func getUserServiceCoreDataModelBy(id: String) -> ServiceCoreDataModel? {
        let serviceCoreDataModels = self.getUserServiceCoreDataModels()
        let serviceCoreDataModel = serviceCoreDataModels?.first(where: { $0.identifier == id })
        return serviceCoreDataModel
    }
}
