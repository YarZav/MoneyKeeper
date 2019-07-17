//
//  DAO.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - DAO
class DAO {
    
    // Properties
    public var dataManager = CoreDataManager.instance
    public let mapper: ModelMapper
    
    // Init
    init(mapper: ModelMapper) {
        self.mapper = mapper
    }
}

// MARK: - Publics
extension DAO {
    
    /// Save to CoreData after updating, deleting or creating
    public func save(callback: @escaping (Error?) -> Void) {
        self.dataManager.saveContext(callback: callback)
    }
    
    /// Get current device id
    public func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    /// Fetch request by entity name
    public func getFetchRequest(entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        return fetchRequest
    }
    
    /// Get core data models by enotity name
    public func getCoreDataModels<T>(entityName: String) -> [T]? {
        do {
            let fetchRequest = self.getFetchRequest(entityName: entityName)
            let results = try self.dataManager.managedObjectContext.fetch(fetchRequest) as? [T]
            return results
        } catch {
            return nil
        }
    }
}
