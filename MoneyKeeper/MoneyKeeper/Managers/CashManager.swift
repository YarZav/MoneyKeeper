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
  private let dao: CashDAOProtocol
  private let mapper: CashModelMapper

  //Init
  init(dao: CashDAOProtocol, mapper: CashModelMapper) {
    self.dao = dao
    self.mapper = mapper
  }
}

// MARK: - Publics
extension CashManager {
  public func saveModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    guard let coreDataModel = mapper.map(model) else {
      let error = CustomError(title: "CashFlow model map error", description: "Unavailable to map business model to coredata model", code: -1)
      return callback(error)
    }

    self.isolationQueue.async(flags: .barrier) { [weak self] in
      self?.dao.saveModel(coreDataModel, callback: callback)
    }
  }

  /// Thread safe get cash flow models from CoreData
  public func getModels() -> [CashModel]? {
    var coreDataModels: [CashCoreDataModel]?
    self.isolationQueue.sync { [weak self] in
      coreDataModels = self?.dao.getModels()
    }
    return coreDataModels?.compactMap({ mapper.map($0) })
  }

  /// Thread safe delete cash flow model from CoreData
  public func deleteModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    self.isolationQueue.async(flags: .barrier) { [weak self] in
      let coreDataModel = self?.mapper.map(model)
      self?.dao.deleteModel(coreDataModel, callback: callback)
    }
  }
}
