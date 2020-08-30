//
//  SettingsCoreDataModel.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Settings)
class SettingsCoreDataModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Settings"), insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
