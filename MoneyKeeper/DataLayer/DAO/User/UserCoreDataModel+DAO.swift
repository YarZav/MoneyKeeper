//
//  UserCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - UserCoreDataProtocol
protocol UserCoreDataProtocol {
    func createUserAccount()                            //Create user account in first laubch
    func getUserCoreDataModel() -> UserCoreDataModel?   //Get current user account
    func deleteUserCoreDataModel()                      //Delete current user account model
}

// MARK: - UserCoreDataModel+DAO
extension DAO: UserCoreDataProtocol {
    
    func createUserAccount() {
        if self.getUserCoreDataModel() == nil {
            let userCoreDataModel = UserCoreDataModel()
            userCoreDataModel.deviceId = self.getDeviceId()
            self.save()
        }
    }
    
    func getUserCoreDataModel() -> UserCoreDataModel? {
        do {
            let fetchRequest = self.getUserFetchRequest()
            let results = try self.dataManager.managedObjectContext.fetch(fetchRequest) as? [UserCoreDataModel]
            let result = results?.first(where: { $0.deviceId == self.getDeviceId() })
            return result
        } catch {
            return nil
        }
    }
    
    func deleteUserCoreDataModel() {
        if let model = self.getUserCoreDataModel() {
            self.dataManager.managedObjectContext.delete(model)
        }
    }
    
    private func getUserFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        return fetchRequest
    }
}
