//
//  CashFlowCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

protocol CashFlowDAOProtocol {
  func getModels() -> [CashFlowCoreDataModel]?
  func deleteModel(_ model: CashFlowCoreDataModel, callback: @escaping (Error?) -> Void)
  func saveModel(_ model: CashFlowCoreDataModel, callback: @escaping (Error?) -> Void)
}

// MARK: - CashFlowCoreDataModel + DAO
class CashFlowDAO {
  private let coreDataManager: CoreDataManager

  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
  }
}

extension CashFlowDAO: CashFlowDAOProtocol {
  func getModels() -> [CashFlowCoreDataModel]? {
    let userCoreDataModel: UserCoreDataModel? = coreDataManager.getCoreDataModels(entityName: "User")?.first
    let cashFlowCareDataModels = userCoreDataModel?.cashFlows?.allObjects as? [CashFlowCoreDataModel]
    return cashFlowCareDataModels
  }

  func deleteModel(_ model: CashFlowCoreDataModel, callback: @escaping (Error?) -> Void) {
    let cashFlowCoreDataModels = getModels()
    if let model = cashFlowCoreDataModels?.first(where: { $0.identifier == model.identifier }) {
      coreDataManager.managedObjectContext.delete(model)
      coreDataManager.saveContext(callback: callback)
    } else {
      callback(nil)
    }
  }
    
  func saveModel(_ model: CashFlowCoreDataModel, callback: @escaping (Error?) -> Void) {
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

