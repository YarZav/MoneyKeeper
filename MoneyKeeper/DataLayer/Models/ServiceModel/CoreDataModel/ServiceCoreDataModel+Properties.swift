//
//  ServiceCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 02/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

extension ServiceCoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceCoreDataModel> {
        return NSFetchRequest<ServiceCoreDataModel>(entityName: "Service")
    }
    
    /// Identifier of model
    @NSManaged public var identifier: String
    
    /// Image name for service item
    @NSManaged public var imageName: String
    
    /// Title for service item
    @NSManaged public var title: String
    
    /// Cash transaction info for service
    @NSManaged public var cashFlow: CashFlowCoreDataModel
    
    /// User model
    @NSManaged public var user: UserCoreDataModel
}
