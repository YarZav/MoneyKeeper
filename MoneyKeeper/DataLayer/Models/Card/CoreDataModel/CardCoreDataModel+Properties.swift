//
//  CardCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by admin on 27/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

extension CardCoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardCoreDataModel> {
        return NSFetchRequest<CardCoreDataModel>(entityName: "Card")
    }
    
    /// Identifier of model
    @NSManaged public var identifier: String
    
    /// Type of bar code
    @NSManaged public var codeType: Int16
    
    /// Value of bar code
    @NSManaged public var codeValue: String
    
    /// User model
    @NSManaged public var user: UserCoreDataModel
}
