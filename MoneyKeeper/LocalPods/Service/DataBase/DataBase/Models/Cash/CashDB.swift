//
//  CashDB.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Cash)
final class CashDB: NSManagedObject, DBIdentifiable {

  // MARK: - DBIdentifiable

  static var entityName: String = "Cash"
  @NSManaged public var identifier: String

  // MARK: - CoreData

  convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CashDB.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CashDB> {
    return NSFetchRequest<CashDB>(entityName: CashDB.entityName)
  }
}

// MARK: - Property

extension CashDB {
  /// Income  OR outcome money
  @NSManaged public var price: Double

  /// Income OR outcome cash flow type
  @NSManaged public var type: Int64

  /// Date of transaction
  @NSManaged public var date: Date

  /// Category for cash flow
  @NSManaged public var category: CategoryDB
}

