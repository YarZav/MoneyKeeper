//
//  DIResolver+CashFlow.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDIResolver
extension DIResolver {
    
    // CashFlow
    func cashFlowViewCotnroller() -> UIViewController {
        let view = CashFlowViewController()
        let interactor = CashFlowInteractor(cashFlowManager: self.cashFlowManager)
        let wireFrame = CashFlowWireFrame(resolver: self)
        let presenter = CashFlowPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        view.type = .outcome
        
        return view
    }
    
    // CashFlowCategory
    func cashFlowCategoryViewCotnroller(model: CashFlowModel, delegate: CashFlowCategoryDelegate?) -> UIViewController {
        let view = CashFlowCategoryViewController()
        let interactor = CashFlowCategoryInteractor(categoryManager: self.categoryManager, cashFlowManager: self.cashFlowManager)
        let wireFrame = CashFlowCategoryWireFrame(resolver: self)
        let presenter = CashFlowCategoryPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        presenter.delegate = delegate
        view.presenter = presenter
        view.model = model
        
        return view
    }
    
    // CashFlowCtegoryDetail
    func cashFlowCategoryDetailViewController(model: CategoryModel, delegate: CashFlowCategoryDetailPresenterDelegate?) -> UIViewController {
        let view = CashFlowCategoryDetailViewController()
        let interactor = CashFlowCategoryDetailInteractor(categoryManager: self.categoryManager)
        let wireFrame = CashFlowCategoryDetailWireFrame(resolver: self)
        let presenter = CashFlowCategoryDetailPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        view.model = model
        presenter.delegate = delegate
        
        return view
    }
    
    // CashFlowDetail
    func cashFlowDetailViewCotnroller() -> UIViewController {
        let view = CashFlowDetailViewController()
        let interactor = CashFlowDetailInteractor(cashFlowManager: self.cashFlowManager)
        let wireFrame = CashFlowDetailWireFrame(resolver: self)
        let presenter = CashFlowDetailPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
    
    // Add new custom cash flow category
    func cashFlowCategoryAddViewCotnroller(delegate: CashFlowCategoryAddDelegate?) -> UIViewController {
        let view = CashFlowCategoryAddViewController()
        let interactor = CashFlowCategoryAddInteractor(categoryManager: self.categoryManager)
        let wireFrame = CashFlowCategoryAddWireFrame(resolver: self)
        let presenter = CashFlowCategoryAddPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        presenter.delegate = delegate
        
        return view
    }
}
