//
//  CashDAO.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business
import DataBase

final class CashDAO {

  // MARK: - Private property

  private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.CashDAO", qos: .userInteractive, attributes: .concurrent)
  private let mapper: CashMapper
  private let coreDataManager: CoreDataManager

  // MARK: - Init

  init(mapper: CashMapper, coreDataManager: CoreDataManager) {
    self.mapper = mapper
    self.coreDataManager = coreDataManager
  }

}

// MARK: - DAOProtocol

extension CashDAO: DAOProtocol {
  func getAll() -> [CashDBModel]? {
    coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
  }
  
  func get(by identifier: UUID) -> CashDBModel? {
    let dataBaseModels = getAll()
    let dataBaseModel = dataBaseModels?.first(where: { $0.identifier == identifier })
    return dataBaseModel
  }
  
  func saveAll(_ models: [CashModel], callback: @escaping (Error?) -> Void) {
    let dataBaseModels = models.compactMap { mapper.map($0) }
    coreDataManager.saveContext(callback: callback)
  }
  
  func save(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    saveAll([model], callback: callback)
  }
  
  func update(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    let dataBaseModel = get(by: model.identifier)
    coreDataManager.saveContext(callback: callback)
  }
  
  func deleteAll(callback: @escaping (Error?) -> Void) {
    let dataBaseModels = getAll()
    dataBaseModels?.forEach({ coreDataManager.managedObjectContext.delete($0) })
    coreDataManager.saveContext(callback: callback)

  }
  
  func delete(by identifier: UUID, callback: @escaping (Error?) -> Void) {
    guard let previousCoreDataModel = get(by: identifier) else { return callback(nil) }
    coreDataManager.managedObjectContext.delete(previousCoreDataModel)
    coreDataManager.saveContext(callback: callback)
  }
  
  typealias DataBaseModel = CashDBModel
  typealias BusinessModel = CashModel

}
