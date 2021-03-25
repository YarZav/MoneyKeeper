//
//  CategoryCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

extension CategoryCoreDataModel {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCoreDataModel> {
    return NSFetchRequest<CategoryCoreDataModel>(entityName: "Category")
  }

  /// Identifier of model
  @NSManaged public var identifier: String

  /// Image name for category item
  @NSManaged public var imageName: String

  /// Title for category item
  @NSManaged public var title: String

  /// Cash transaction info for category
  @NSManaged public var cashFlow: CashCoreDataModel
}
