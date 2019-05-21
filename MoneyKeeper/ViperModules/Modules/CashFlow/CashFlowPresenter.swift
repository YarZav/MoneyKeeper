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
    private var model = CashFlowModel(type: .consumption)
    
    //Init
    init(view: CashFlowViewControllerProtocol, interactor: CashFlowInteractorProtocol, wireFrame: CashFlowWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowPresenterProtocol
extension CashFlowPresenter: CashFlowPresenterProtocol {
    
    func viewWillApepar() {
        var total = NSNumber(value: 0)
        
        let models = self.interactor.getCashFlowModels()
        models.forEach { total = NSNumber(value: total.doubleValue + $0.price.doubleValue) }
        
        let numberFormatter = NumberFormatter.numberFormatter(numberStyle: .currency)
        let totalString = numberFormatter.string(from: total)

        self.view?.setTotalPrice(totalString)
    }
    
    func presentCashFlowCategory(price: String) {
        if let priceDouble = Double(price) {
            self.model.price = NSNumber(value: priceDouble)
        } else {
            self.model.price = NSNumber(value: 0)
        }
        
        self.wireFrame.cashFlowCategory(from: self.view, model: self.model, delegate: self)
    }
}

// MARK: - CashFlowCategoryDelegate
extension CashFlowPresenter: CashFlowCategoryDelegate {
    
    func clearPrice() {
        self.model = CashFlowModel(type: .consumption)
        self.view?.dropPrice()
    }
}

