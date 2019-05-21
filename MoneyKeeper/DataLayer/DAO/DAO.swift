//
//  DAO.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - DaoCommonProtocol
protocol DaoCommonProtocol {
    func save()                     //Save data after add, update, delete
    func getDeviceId() -> String    //Get curent device ID
}

// MARK: - DAO
class DAO {
    
    // Properties
    public var dataManager = CoreDataManager.instance
    
    // Init
    init() { }
}

// MARK: - DaoCommonProtocol
extension DAO: DaoCommonProtocol {
    
    func save() {
        self.dataManager.saveContext { (error) in }
    }
    
    func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
}
