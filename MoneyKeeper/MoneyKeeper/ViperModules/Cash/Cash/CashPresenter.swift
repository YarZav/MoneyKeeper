//
//  CashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashPresenter
class CashPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashViewControllerProtocol?
    private let interactor: CashInteractorProtocol
    private let wireFrame: CashWireFrameProtocol
    
    private var totalPrice = Decimal(0)
    
    //Init
    init(view: CashViewControllerProtocol, interactor: CashInteractorProtocol, wireFrame: CashWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    override func languageChanged() {
        self.view?.updateStringLocalization()
    }
}

// MARK: - CashPresenterProtocol
extension CashPresenter: CashPresenterProtocol {
    
    /// Update total price from cash models
    func viewDidApepar(type: CashType) {
        self.totalPrice = self.interactor.getTotalCash(type: type)
        self.view?.setTotalPrice(self.totalPrice.toString(.currency))
    }
    
    /// Choose cash category
    func presentCashCategory(price: String, type: CashType) {
        let model = CashModel(type: type)
        if let decimalPrice = Decimal(string: price) {
            model.price = decimalPrice
        }
        self.wireFrame.cashCategory(from: self.view, model: model, delegate: self)
    }
    
    /// Save cash model
    func savedModel(_ model: CashModel) {
        Thread.current.doInMainThread {
            self.totalPrice += model.price
            self.view?.setTotalPrice(self.totalPrice.toString(.currency))
        }
    }
    
    /// Delete cash model
    func deletedModel(_ model: CashModel) {
        Thread.current.doInMainThread {
            self.totalPrice -= model.price
            self.view?.setTotalPrice(self.totalPrice.toString(.currency))
        }
    }
}

// MARK: - CashFlowCategoryDelegate
extension CashPresenter: CashFlowCategoryDelegate {
    
    func clearPrice() {
        self.view?.dropPrice()
    }
}

