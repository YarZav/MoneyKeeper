//
//  CardCoreDataModel+Properties.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import CoreData

extension CardCoreDataModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardCoreDataModel> {
        return NSFetchRequest<CardCoreDataModel>(entityName: "Card")
    }
    
    /// Identifier of model
    @NSManaged public var identifier: String
    
    /// Date of add
    @NSManaged public var addDate: Date
    
    /// Bar code value
    @NSManaged public var code: String
    
    /// Bar code type
    @NSManaged public var type: String
    
    /// Name for bar code
    @NSManaged public var title: String
    
    /// User who do transaction
    @NSManaged public var user: UserCoreDataModel
}

