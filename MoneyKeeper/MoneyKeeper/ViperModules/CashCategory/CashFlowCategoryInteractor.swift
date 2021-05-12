//
//  CashFlowCategoryInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashFlowCategoryInteractor
class CashFlowCategoryInteractor {
    
    // Properties
//    private var categoryManager: CategoryManager
    private var cashFlowManager: CashManager
    
    // Init
    init(/*categoryManager: CategoryManager, */cashFlowManager: CashManager) {
//        self.categoryManager = categoryManager
        self.cashFlowManager = cashFlowManager
    }
}

// MARK: - CashFlowCategoryInteractorProtocol
extension CashFlowCategoryInteractor: CashFlowCategoryInteractorProtocol {
    
//    func getCategoryItems() -> [CategoryModel] {
//        let categoryModels = categoryManager.getModels()
//        return categoryModels ?? []
//    }
    
    func saveCashFlowModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
//        self.cashFlowManager.saveCashFlowModel(model, callback: callback)
    }
}
