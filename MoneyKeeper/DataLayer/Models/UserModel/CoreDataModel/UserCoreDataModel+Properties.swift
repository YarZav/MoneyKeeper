//
//  UserCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

extension UserCoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreDataModel> {
        return NSFetchRequest<UserCoreDataModel>(entityName: "User")
    }
    
    /// Device identifier
    @NSManaged public var deviceId: String
    
    /// User name
    @NSManaged public var userName: String?
    
    /// Cash transactions for user
    @NSManaged public var cashFlows: NSSet?
    
    /// Categories for user
    @NSManaged public var categories: NSSet?
    
    /// Cards for user
    @NSManaged public var cards: NSSet?
    
    /// Settings for user
    @NSManaged public var settings: SettingsCoreDataModel?
}
