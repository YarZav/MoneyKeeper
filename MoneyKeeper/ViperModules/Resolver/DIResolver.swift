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
    
    /// Thread safe cash flow manager
    public var cashFlowManager: CashFlowManager
    
    /// Thread safe category manager
    public var categoryManager: CategoryManager
    
    /// Thread safe card manager
    public var cardManager: CardManager
    
    /// Get dao pattern for core data models
    public var dao: DAO

    //Init
    init(dao: DAO) {
        self.dao = dao
        self.cashFlowManager = CashFlowManager(dao: self.dao)
        self.categoryManager = CategoryManager(dao: self.dao)
        self.cardManager = CardManager(dao: self.dao)
    }
}
