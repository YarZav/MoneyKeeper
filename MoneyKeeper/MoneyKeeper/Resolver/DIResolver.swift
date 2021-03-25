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
  public var cashFlowManager: CashManager

  /// Thread safe category manager
  public var categoryManager: CategoryManager

  /// Thread safe card manager
  public var cardManager: CardManager

  //Init
  init() {
    let cashDAO = CashDAO(coreDataManager: coreDataManager)
    let categoryDAO = CategoryDAO(coreDataManager: coreDataManager)
    let cardDAO = CardDAO(coreDataManager: coreDataManager)

    self.cashFlowManager = CashManager(dao: cashDAO, mapper: CashModelMapper())
    self.categoryManager = CategoryManager(dao: categoryDAO)
    self.cardManager = CardManager(dao: cardDAO)
  }
}
