//
//  CashFlowCategoryAddInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 20/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashFlowCategoryAddInteractor
class CashFlowCategoryAddInteractor {
    
    private let categoryManager: CategoryManager
    
    init(categoryManager: CategoryManager) {
        self.categoryManager = categoryManager
    }
}

// MARK: - CashFlowCategoryAddInteractorProtocol
extension CashFlowCategoryAddInteractor: CashFlowCategoryAddInteractorProtocol {
    
    func getImageNamed() -> [String] {
        return CategoryManager.getDefaultImageNames()
    }
    
    func saveCategory(_ model: CategoryModel, callback: @escaping (Error?) -> Void) {
        categoryManager.saveModel(model, callback: callback)
    }
}
