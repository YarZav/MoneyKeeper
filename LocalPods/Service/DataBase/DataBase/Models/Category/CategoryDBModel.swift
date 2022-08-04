//
//  CategoryDBModel.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 8/4/22.
//

import CoreData

@objc(CashCategory)
public final class CashCategoryDBModel: NSManagedObject {

  // MARK: - CoreData

  public convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CashCategoryDBModel.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CashCategoryDBModel> {
    return NSFetchRequest<CashCategoryDBModel>(entityName: CashCategoryDBModel.entityName)
  }

}

// MARK: - DBModelIdentifiable

extension CashCategoryDBModel: DBModelIdentifiable {

  static var entityName: String = "CashCategory"

  /// Identifier of model
  @NSManaged public var identifier: UUID

  /// Title of model
  @NSManaged public var title: String

}

