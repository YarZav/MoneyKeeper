//
//  CashFlowCategoryDetailPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashFlowCategoryDetailPresenterDelegate
protocol CashFlowCategoryDetailPresenterDelegate: class {
    func didDeleteCategoryModel(_ model: CategoryModel)
}

// MARK: - CashFlowCategoryDetailPresenter
class CashFlowCategoryDetailPresenter: BasePresenter {
    
    // Properties
    private weak var view: CashFlowCategoryDetailViewControllerProtocol?
    private let interactor: CashFlowCategoryDetailInteractorProtocol
    private let wireFrame: CashFlowCategoryDetailWireFrameProtocol
    public weak var delegate: CashFlowCategoryDetailPresenterDelegate?
    
    // Init
    init(view: CashFlowCategoryDetailViewControllerProtocol, interactor: CashFlowCategoryDetailInteractorProtocol, wireFrame: CashFlowCategoryDetailWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowCategoryDetailPresenterProtocol
extension CashFlowCategoryDetailPresenter: CashFlowCategoryDetailPresenterProtocol {
    
    func deleteCategoryModel(_ model: CategoryModel) {
        self.interactor.deleteCategoryModel(model) { [weak self] (error) in
            guard let strongSelf = self else { return }
            Thread.current.doInMainThread {
                strongSelf.delegate?.didDeleteCategoryModel(model)
            }
        }
    }
}
