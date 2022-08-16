//
//  CashDAO.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service

// TODO: - Перенести куда-то

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

  typealias DataBaseModel = CashDBModel
  typealias BusinessModel = CashModel

  func getAll() -> [CashModel]? {
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    return dataBaseModels?.compactMap { mapper.map($0) }
  }

  func get(by identifier: UUID) -> CashModel? {
    let models = getAll()
    let model = models?.first(where: { $0.identifier == identifier })
    return model
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
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    dataBaseModels?.forEach({ coreDataManager.managedObjectContext.delete($0) })
    coreDataManager.saveContext(callback: callback)
  }

  func delete(by identifier: UUID, callback: @escaping (Error?) -> Void) {
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    let dataBaseModel = dataBaseModels?.first(where: { $0.identifier == identifier })
    guard let dataBaseModel = dataBaseModel else { return callback(nil) }
    coreDataManager.managedObjectContext.delete(dataBaseModel)
    coreDataManager.saveContext(callback: callback)
  }

}
