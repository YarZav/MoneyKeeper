//
//  DIResolver.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - DIResolver
class DIResolver {
    
    /// Mapper for models, example CoreData to Business model OR Business to CoreData model
    public var mapper: ModelMapper
    
    /// Get dao pattern for core data models
    public var dao: DAO

    //Init
    init() {
        self.dao = DAO()
        self.mapper = ModelMapper()
    }
}
