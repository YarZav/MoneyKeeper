//
//  CashFlowCoreDataModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

@objc(CashFlow)
class CashFlowCoreDataModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "CashFlow"), insertInto: CoreDataManager.shared.managedObjectContext)
    }
}

