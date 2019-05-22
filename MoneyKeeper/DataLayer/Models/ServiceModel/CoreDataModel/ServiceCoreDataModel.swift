//
//  ServiceCoreDataModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

@objc(Service)
class ServiceCoreDataModel: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Service"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
