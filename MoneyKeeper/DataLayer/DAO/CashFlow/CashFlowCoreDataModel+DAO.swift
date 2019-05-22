//
//  CashFlowCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CashFlowCoreDataProtocol
protocol CashFlowCoreDataProtocol {
    func getCashFlowCoreDataModelBy(id: String) -> CashFlowCoreDataModel?
    func getCashFlowCoreDataModels() -> [CashFlowCoreDataModel]
    func deleteCashFlowCoreDataModelBy(id: String)
    func deleteCashFlowCoreDataModels()
}

// MARK: - CashFlowCoreDataProtocol
extension DAO: CashFlowCoreDataProtocol {
    
    func getCashFlowCoreDataModels() -> [CashFlowCoreDataModel] {
        do {
            let fetchRequest = self.getCashFlowFetchRequest()
            let results = try self.dataManager.managedObjectContext.fetch(fetchRequest) as? [CashFlowCoreDataModel]
            return results ?? []
        } catch {
            return []
        }
    }
    
    func getCashFlowCoreDataModelBy(id: String) -> CashFlowCoreDataModel? {
        let coreDataModels = self.getCashFlowCoreDataModels()
        let coreDataModel = coreDataModels.first { $0.identifier == id }
        return coreDataModel
    }
    
    func deleteCashFlowCoreDataModelBy(id: String) {
        if let model = self.getCashFlowCoreDataModelBy(id: id) {
            self.dataManager.managedObjectContext.delete(model)
        }
    }
    
    func deleteCashFlowCoreDataModels() {
        let models = self.getCashFlowCoreDataModels()
        models.forEach {
            self.dataManager.managedObjectContext.delete($0)
        }
    }
    
    private func getCashFlowFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CashFlow")
        return fetchRequest
    }
}

