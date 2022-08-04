//
//  DAOImp.swift
//  DataBase
//
//  Created by y.zavyalov on 22.04.2021.
//

import CoreData

final class DAOImp<Template: NSManagedObject & DBModelIdentifiable> {

  // MARK: - Private property

  private let coreDataManager: CoreDataManager

  // MARK: - Init

  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
  }

}

// MARK: - DAO

extension DAOImp: DAO {

  typealias DataBaseModel = Template

  func getAll() -> [Template]? {
    return coreDataManager.getCoreDataModels(entityName: Template.entityName)
  }

  func get(by identifier: String) -> Template? {
    return getAll()?.first(where: { $0.identifier == identifier })
  }

  func saveAll(_ models: [Template], callback: @escaping (Error?) -> Void) {
    var previousCoreDataModels = getAll()
    previousCoreDataModels?.append(contentsOf: models)
    coreDataManager.saveContext(callback: callback)
  }

  func save(_ model: Template, callback: @escaping (Error?) -> Void) {
    saveAll([model], callback: callback)
  }

  func deleteAll(callback: @escaping (Error?) -> Void) {
    let previousCoreDataModels = getAll()
    previousCoreDataModels?.forEach({ coreDataManager.managedObjectContext.delete($0) })
    coreDataManager.saveContext(callback: callback)
  }

  func delete(by identifier: String, callback: @escaping (Error?) -> Void) {
    guard let previousCoreDataModel = get(by: identifier) else { return callback(nil) }
    coreDataManager.managedObjectContext.delete(previousCoreDataModel)
    coreDataManager.saveContext(callback: callback)
  }

}
