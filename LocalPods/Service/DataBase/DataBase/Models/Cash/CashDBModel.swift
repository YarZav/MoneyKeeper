//
//  CashDBModel.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Cash)
public final class CashDBModel: NSManagedObject {

  // MARK: - CoreData

  public convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CashDBModel.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CashDBModel> {
    return NSFetchRequest<CashDBModel>(entityName: CashDBModel.entityName)
  }

}

// MARK: - DBModelIdentifiable

extension CashDBModel: DBModelIdentifiable {

  public static var entityName: String = "Cash"

  /// Identifier of model
  @NSManaged public var identifier: UUID

  /// Income  OR outcome money
  @NSManaged public var price: Double

  /// Income OR outcome cash flow type
  @NSManaged public var type: Int64

  /// Date of transaction
  @NSManaged public var date: Date

  /// Category
  @NSManaged public var cashCategory: CashCategoryDBModel

}
