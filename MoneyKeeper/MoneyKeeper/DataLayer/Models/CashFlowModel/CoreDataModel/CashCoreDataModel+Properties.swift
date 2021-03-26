//
//  CashCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

extension CashCoreDataModel {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CashCoreDataModel> {
    return NSFetchRequest<CashCoreDataModel>(entityName: "Cash")
  }

  /// Identifier of model
  @NSManaged public var identifier: String

  /// Income  OR outcome money
  @NSManaged public var price: Double

  /// Income OR outcome cash flow type
  @NSManaged public var type: Int64

  /// Date of transaction
  @NSManaged public var date: Date

  /// Category for cash flow
  @NSManaged public var category: CategoryCoreDataModel
}
