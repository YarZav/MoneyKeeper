//
//  UserCoreDataModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

@objc(User)
class UserCoreDataModel: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "User"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
