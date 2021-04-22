//
//  CardDB.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Card)
final class CardDB: NSManagedObject, DBIdentifiable {

  // MARK: - DBIdentifiable

  static var entityName: String = "Card"
  @NSManaged public var identifier: String

  // MARK: - CoreData

  convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CardDB.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CardDB> {
    return NSFetchRequest<CardDB>(entityName: CardDB.entityName)
  }
}

// MARK: - Property

extension CardDB {
  /// Date of add
  @NSManaged public var addDate: Date

  /// Bar code value
  @NSManaged public var code: String

  /// Bar code type
  @NSManaged public var type: String

  /// Name for bar code
  @NSManaged public var title: String
}
