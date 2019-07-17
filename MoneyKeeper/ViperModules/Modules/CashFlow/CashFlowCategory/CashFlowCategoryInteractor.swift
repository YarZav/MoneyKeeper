//
//  CashFlowCategoryInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowCategoryInteractor
class CashFlowCategoryInteractor {
    
    // Properties
    private var categoryManager: CategoryManager
    private var cashFlowManager: CashFlowManager
    
    // Init
    init(categoryManager: CategoryManager, cashFlowManager: CashFlowManager) {
        self.categoryManager = categoryManager
        self.cashFlowManager = cashFlowManager
    }
}

// MARK: - CashFlowCategoryInteractorProtocol
extension CashFlowCategoryInteractor: CashFlowCategoryInteractorProtocol {
    
    func getCategoryItems() -> [CategoryModel] {
        let categoryModels = self.categoryManager.getCategoryModels()
        return categoryModels ?? []
    }
    
    func saveCashFlowModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void) {
        self.cashFlowManager.saveCashFlowModel(model, callback: callback)
    }
    
    func getTotalCashFlow(type: CashFlowType) -> Decimal {
        return self.cashFlowManager.getTotalPriceCashFlow(by: type)
    }
}
