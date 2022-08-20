//
//  CashDAO.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public final class CashDAO {

  // MARK: - Private property

  private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.CashDAO", qos: .userInteractive, attributes: .concurrent)
  private let cashMapper: CashMapper
  private let coreDataManager: CoreDataManager

  // MARK: - Init

  public init(cashMapper: CashMapper, coreDataManager: CoreDataManager) {
    self.cashMapper = cashMapper
    self.coreDataManager = coreDataManager
  }

}

// MARK: - DAOProtocol

extension CashDAO: DAOProtocol {

  public typealias DataBaseModel = CashDBModel
  public typealias BusinessModel = CashModel

  public func getAll() -> [CashModel]? {
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    return dataBaseModels?.compactMap { cashMapper.map($0) }
  }

  public func get(by identifier: UUID) -> CashModel? {
    let models = getAll()
    let model = models?.first(where: { $0.identifier == identifier })
    return model
  }

  public func saveAll(_ models: [CashModel], callback: @escaping (Error?) -> Void) {
    let dataBaseModels = models.compactMap { cashMapper.map($0) }
    coreDataManager.saveContext(callback: callback)
  }

  public func save(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    saveAll([model], callback: callback)
  }

  public func update(_ model: CashModel, callback: @escaping (Error?) -> Void) {
    let dataBaseModel = get(by: model.identifier)
    coreDataManager.saveContext(callback: callback)
  }

  public func deleteAll(callback: @escaping (Error?) -> Void) {
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    dataBaseModels?.forEach({ coreDataManager.managedObjectContext.delete($0) })
    coreDataManager.saveContext(callback: callback)
  }

  public func delete(by identifier: UUID, callback: @escaping (Error?) -> Void) {
    let dataBaseModels: [CashDBModel]? = coreDataManager.getCoreDataModels(entityName: DataBaseModel.entityName)
    let dataBaseModel = dataBaseModels?.first(where: { $0.identifier == identifier })
    guard let dataBaseModel = dataBaseModel else { return callback(nil) }
    coreDataManager.managedObjectContext.delete(dataBaseModel)
    coreDataManager.saveContext(callback: callback)
  }

}
