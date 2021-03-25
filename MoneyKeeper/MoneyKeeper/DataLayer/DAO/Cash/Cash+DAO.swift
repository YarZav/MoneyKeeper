//
//  Cash+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

protocol CashDAOProtocol {
  func getModels() -> [CashCoreDataModel]?
  func deleteModel(_ model: CashCoreDataModel?, callback: @escaping (Error?) -> Void)
  func saveModel(_ model: CashCoreDataModel, callback: @escaping (Error?) -> Void)
}

// MARK: - CashDAO
class CashDAO {
  private let coreDataManager: CoreDataManager

  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
  }
}

extension CashDAO: CashDAOProtocol {
  func getModels() -> [CashCoreDataModel]? {
//    let userCoreDataModel: UserCoreDataModel? = coreDataManager.getCoreDataModels(entityName: "User")?.first
//    let cashCareDataModels = userCoreDataModel?.cashFlows?.allObjects as? [CashFlowCoreDataModel]
//    return cashFlowCareDataModels
    return nil
  }

  func deleteModel(_ model: CashCoreDataModel?, callback: @escaping (Error?) -> Void) {
    let cashCoreDataModels = getModels()
    if let model = cashCoreDataModels?.first(where: { $0.identifier == model?.identifier }) {
      coreDataManager.managedObjectContext.delete(model)
      coreDataManager.saveContext(callback: callback)
    } else {
      callback(nil)
    }
  }
    
  func saveModel(_ model: CashCoreDataModel, callback: @escaping (Error?) -> Void) {
//    var cashFlowCoreDataModels = (userCoreDataModel.cashFlows?.allObjects) as? [CashFlowCoreDataModel]
//
//    if cashFlowCoreDataModels == nil {
//      userCoreDataModel.cashFlows = NSSet(array: [model])
//    } else {
//      cashFlowCoreDataModels?.append(model)
//      userCoreDataModel.cashFlows = NSSet(array: (cashFlowCoreDataModels ?? []))
//    }
//    coreDataManager.saveContext(callback: callback)
  }
}

