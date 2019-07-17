//
//  CardCoreDataModel.swift
//  MoneyKeeper
//
//  Created by admin on 27/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

@objc(Card)
class CardCoreDataModel: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Card"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
