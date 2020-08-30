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
    private let coreDataManager = CoreDataManager.shared
    
    /// Thread safe cash flow manager
    public var cashFlowManager: CashFlowManager
    
    /// Thread safe category manager
    public var categoryManager: CategoryManager
    
    /// Thread safe card manager
    public var cardManager: CardManager

    public let userDAO = UserDAO(categoryMapper: CategoryModelMapper(), coreDataManager: CoreDataManager.shared)

    //Init
    init() {
        let cashFlowDAO = CashFlowDAO(coreDataManager: coreDataManager)
        let categoryDAO = CategoryDAO(coreDataManager: coreDataManager)
        let cardDAO = CardDAO(coreDataManager: coreDataManager)
//        let userDAO = UserDAO(categoryMapper: CategoryModelMapper(), coreDataManager: CoreDataManager.shared)
        
        self.cashFlowManager = CashFlowManager(dao: cashFlowDAO, mapper: CashFlowModelMapper())
        self.categoryManager = CategoryManager(dao: categoryDAO)
        self.cardManager = CardManager(dao: cardDAO)
    }
}
