//
//  CashFlowPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowPresenter
class CashFlowPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowViewControllerProtocol?
    private let interactor: CashFlowInteractorProtocol
    private let wireFrame: CashFlowWireFrameProtocol
    
    private var totalPrice = Decimal(0)
    
    //Init
    init(view: CashFlowViewControllerProtocol, interactor: CashFlowInteractorProtocol, wireFrame: CashFlowWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    override func languageChanged() {
        self.view?.updateStringLocalization()
    }
}

// MARK: - CashFlowPresenterProtocol
extension CashFlowPresenter: CashFlowPresenterProtocol {
    
    /// Update total price from cash flow models
    func viewDidApepar(type: CashFlowType) {
        if let observer = self.view as? CashFlowManagerDelegate {
            self.interactor.addObserver(observer)
        }
        
        self.totalPrice = self.interactor.getTotalCashFlow(type: type)
        self.view?.setTotalPrice(self.totalPrice.toString(.currency))
    }
    
    /// Choose cash flow category
    func presentCashFlowCategory(price: String, type: CashFlowType) {
        let model = CashFlowModel(type: type)
        if let decimalPrice = Decimal(string: price) {
            model.price = decimalPrice
        }
        self.wireFrame.cashFlowCategory(from: self.view, model: model, delegate: self)
    }
    
    /// Save cash flow model
    func savedModel(_ model: CashFlowModel) {
        Thread.current.doInMainThread {
            self.totalPrice += model.price
            self.view?.setTotalPrice(self.totalPrice.toString(.currency))
        }
    }
    
    /// Delete cash flow model
    func deletedModel(_ model: CashFlowModel) {
        Thread.current.doInMainThread {
            self.totalPrice -= model.price
            self.view?.setTotalPrice(self.totalPrice.toString(.currency))
        }
    }
}

// MARK: - CashFlowCategoryDelegate
extension CashFlowPresenter: CashFlowCategoryDelegate {
    
    func clearPrice() {
        self.view?.dropPrice()
    }
}

