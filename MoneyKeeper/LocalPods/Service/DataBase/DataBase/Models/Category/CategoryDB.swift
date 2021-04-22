//
//  CategoryDB.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Category)
final class CategoryDB: NSManagedObject, DBIdentifiable {

  // MARK: - DBIdentifiable

  static var entityName: String = "Category"
  @NSManaged public var identifier: String

  // MARK: - CoreData

  convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CategoryDB.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDB> {
    return NSFetchRequest<CategoryDB>(entityName: CategoryDB.entityName)
  }
}

// MARK: - Property

extension CategoryDB { 
  /// Image name for category item
  @NSManaged public var imageName: String

  /// Title for category item
  @NSManaged public var title: String

  /// Cash transaction info for category
  @NSManaged public var cashFlow: CashDB
}
