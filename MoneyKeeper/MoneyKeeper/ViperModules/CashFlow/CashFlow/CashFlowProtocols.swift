//
//  CashFlowProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

//Presenter -> View
protocol CashFlowViewControllerProtocol: class {
    func updateStringLocalization()
    func dropPrice()
    func setTotalPrice(_ total: String?)
}

//View -> Presenter
protocol CashFlowPresenterProtocol {
    func viewDidApepar(type: CashFlowType)
    func presentCashFlowCategory(price: String, type: CashFlowType)
    func savedModel(_ model: CashFlowModel)
    func deletedModel(_ model: CashFlowModel)
}

//Presenter - Interactor
protocol CashFlowInteractorProtocol {
    func getTotalCashFlow(type: CashFlowType) -> Decimal
}

//Presenter - WireFrame
protocol CashFlowWireFrameProtocol {
    func cashFlowCategory(from view: CashFlowViewControllerProtocol?, model: CashFlowModel, delegate: CashFlowCategoryDelegate?)
}
