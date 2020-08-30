//
//  CategoryCoreDataModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Category)
class CategoryCoreDataModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Category"), insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
