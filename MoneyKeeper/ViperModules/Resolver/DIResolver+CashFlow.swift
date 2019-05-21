//
//  DIResolver+CashFlow.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDIResolver
protocol CashFlowDIResolver {
    func cashFlowViewCotnroller() -> UIViewController
    func cashFlowCategoryViewCotnroller(model: CashFlowModel, delegate: CashFlowCategoryDelegate?) -> UIViewController
    func cashFlowCategoryDetailViewController(model: CashFlowModel) -> UIViewController
    func cashFlowDetailViewCotnroller() -> UIViewController
}

// MARK: - DIResolver + CashFlowDIResolver
extension DIResolver: CashFlowDIResolver {
    
    // CashFlow
    func cashFlowViewCotnroller() -> UIViewController {
        let view = CashFlowViewController()
        let interactor = CashFlowInteractor(dao: self.dao, mapper: self.mapper)
        let wireFrame = CashFlowWireFrame(resolver: self)
        let presenter = CashFlowPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
    
    // CashFlowCategory
    func cashFlowCategoryViewCotnroller(model: CashFlowModel, delegate: CashFlowCategoryDelegate?) -> UIViewController {
        let view = CashFlowCategoryViewController()
        let interactor = CashFlowCategoryInteractor(dao: self.dao, mapper: self.mapper)
        let wireFrame = CashFlowCategoryWireFrame(resolver: self)
        let presenter = CashFlowCategoryPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        presenter.delegate = delegate
        view.presenter = presenter
        view.model = model
        
        return view
    }
    
    // CashFlowCtegoryDetail
    func cashFlowCategoryDetailViewController(model: CashFlowModel) -> UIViewController {
        let view = CashFlowCategoryDetailViewController()
        let interactor = CashFlowCategoryDetailInteractor()
        let wireFrame = CashFlowCategoryDetailWireFrame(resolver: self)
        let presenter = CashFlowCategoryDetailPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        view.model = model
        
        return view
    }
    
    // CashFlowDetail
    func cashFlowDetailViewCotnroller() -> UIViewController {
        let view = CashFlowDetailViewController()
        let interactor = CashFlowDetailInteractor(dao: self.dao, mapper: self.mapper)
        let wireFrame = CashFlowDetailWireFrame(resolver: self)
        let presenter = CashFlowDetailPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
}
