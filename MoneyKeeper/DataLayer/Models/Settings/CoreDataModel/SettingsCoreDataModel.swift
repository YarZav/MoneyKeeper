//
//  SettingsCoreDataModel.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

@objc(Settings)
class SettingsCoreDataModel: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Settings"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
