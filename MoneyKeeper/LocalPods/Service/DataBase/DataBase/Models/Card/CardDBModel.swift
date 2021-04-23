//
//  CardDBModel.swift
//  Database
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Card)
public final class CardDBModel: NSManagedObject, DBModelIdentifiable {

  // MARK: - DBIdentifiable

  static var entityName: String = "Card"
  @NSManaged public var identifier: String

  // MARK: - CoreData

  public convenience init() {
    let manager = CoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: CardDBModel.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CardDBModel> {
    return NSFetchRequest<CardDBModel>(entityName: CardDBModel.entityName)
  }
}

// MARK: - Property

extension CardDBModel {
  /// Date of add
  @NSManaged public var date: Date

  /// Bar code value
  @NSManaged public var code: String

  /// Bar code type
  @NSManaged public var type: String

  /// Name for bar code
  @NSManaged public var title: String
}
