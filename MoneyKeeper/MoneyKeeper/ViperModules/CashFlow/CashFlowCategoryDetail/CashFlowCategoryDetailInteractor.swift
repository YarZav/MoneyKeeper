//
//  CashFlowCategoryDetailInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowCategoryDetailInteractor
class CashFlowCategoryDetailInteractor {
    
    private let categoryManager: CategoryManager
    
    init(categoryManager: CategoryManager) {
        self.categoryManager = categoryManager
    }
}

// MARK: - CashFlowCategoryDetailInteractorProtocol
extension CashFlowCategoryDetailInteractor: CashFlowCategoryDetailInteractorProtocol {
    
    func deleteCategoryModel(_ model: CategoryModel, callback: @escaping (Error?) -> Void) {
        categoryManager.deleteModel(model, callback: callback)
    }
}
