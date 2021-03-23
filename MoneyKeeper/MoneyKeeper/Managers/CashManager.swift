//
//  CashManager.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

/// Thread safe manager to get and set cash models
class CashManager {
  // Property
  private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.Cash", qos: .userInteractive, attributes: .concurrent)
  private let dao: CashFlowDAOProtocol
  private let mapper: CashFlowModelMapper

  //Init
  init(dao: CashFlowDAOProtocol, mapper: CashFlowModelMapper) {
    self.dao = dao
    self.mapper = mapper
  }
}

// MARK: - Publics
extension CashManager {
  public func saveModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
//    guard let coreDataModel = mapper.map(model) else {
//      let error = CustomError(title: "CashFlow model map error", description: "Unavailable to map business model to coredata model", code: -1)
//      callback(error)
//      return
//    }
//
//    self.isolationQueue.async(flags: .barrier) {
//      self.dao.saveModel(coreDataModel, callback: callback)
//    }
  }
    
  /// Thread safe get cash flow models from CoreData
  public func getModels() -> [CashModel]? {
//        var coreDataModels: [CashFlowCoreDataModel]?
//        self.isolationQueue.sync {
//            coreDataModels = self.dao.getModels()
//        }
//        let models = coreDataModels?.forEach({ mapper.map($0) })
//        return models
    return nil
  }
    
  /// Thread safe delete cash flow model from CoreData
  public func deleteModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
//        self.isolationQueue.async(flags: .barrier) {
//            self.dao.deleteModel(model, callback: callback)
//        }
  }
}
