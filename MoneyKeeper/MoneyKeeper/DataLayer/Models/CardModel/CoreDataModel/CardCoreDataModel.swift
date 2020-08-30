//
//  CardCoreDataModel.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(Card)
class CardCoreDataModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Card"), insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
