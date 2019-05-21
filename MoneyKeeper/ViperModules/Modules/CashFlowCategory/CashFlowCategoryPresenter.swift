//
//  CashFlowCategoryPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CashFlowCategoryDelegate
protocol CashFlowCategoryDelegate: class {
    func clearPrice()
}

// MARK: - CashFlowPresenter
class CashFlowCategoryPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowCategoryViewControllerProtocol?
    private let interactor: CashFlowCategoryInteractorProtocol
    private let wireFrame: CashFlowCategoryWireFrameProtocol
    public weak var delegate: CashFlowCategoryDelegate?
    
    //Init
    init(view: CashFlowCategoryViewControllerProtocol, interactor: CashFlowCategoryInteractorProtocol, wireFrame: CashFlowCategoryWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowCategoryPresenterProtocol
extension CashFlowCategoryPresenter: CashFlowCategoryPresenterProtocol {
    
    func viewDidLoad() {
        let items = self.interactor.getCategoryItems()
        self.view?.setItems(items)
    }
    
    func cashFlowDetailCategory(transition: CashFlowCategoryTransitionDelegate, model: CashFlowModel) {
        self.wireFrame.cashFlowCategoryDetail(from: self.view, transition: transition, model: model)
    }
    
    func saveCashFlowModel(_ model: CashFlowModel) {
        self.interactor.saveCashFlowModel(model)
        self.view?.succedSave()
    }
    
    func popViewController() {
        self.delegate?.clearPrice()
        self.wireFrame.popViewController(from: self.view)
    }
}
