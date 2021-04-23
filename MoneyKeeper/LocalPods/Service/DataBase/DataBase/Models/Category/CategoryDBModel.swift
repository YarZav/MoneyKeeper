//
//  CategoryDBModel.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Category)
public final class CategoryDBModel: NSManagedObject, DBModelIdentifiable {

  // MARK: - DBIdentifiable

  static var entityName: String = "Category"
  @NSManaged public var identifier: String

  // MARK: - CoreData

  public convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CategoryDBModel.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDBModel> {
    return NSFetchRequest<CategoryDBModel>(entityName: CategoryDBModel.entityName)
  }
}

// MARK: - Property

extension CategoryDBModel {
  /// Image name for category item
  @NSManaged public var imageName: String

  /// Title for category item
  @NSManaged public var title: String

  /// Cash transaction info for category
  @NSManaged public var cash: CashDBModel
}
