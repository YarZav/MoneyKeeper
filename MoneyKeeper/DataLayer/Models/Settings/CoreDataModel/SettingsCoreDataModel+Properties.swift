//
//  SettingsCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

extension SettingsCoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsCoreDataModel> {
        return NSFetchRequest<SettingsCoreDataModel>(entityName: "Settings")
    }
    
    /// Language type
    @NSManaged public var languageCode: Int64
    
    /// Currency type
    @NSManaged public var currencyCode: Int64
    
    /// Push local sending
    @NSManaged public var push: Bool
    
    /// save core data in iCloud
    @NSManaged public var iCloud: Bool
    
    /// App pincode
    @NSManaged public var pincode: String
    
    /// Use touchID
    @NSManaged public var touchID: Bool
    
    /// Show hint
    @NSManaged public var showHint: Bool
    
    /// User model
    @NSManaged public var user: UserCoreDataModel
}
