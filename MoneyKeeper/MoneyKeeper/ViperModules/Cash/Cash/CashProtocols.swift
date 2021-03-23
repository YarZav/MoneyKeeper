//
//  CashProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

//Presenter -> View
protocol CashViewControllerProtocol: class {
    func updateStringLocalization()
    func dropPrice()
    func setTotalPrice(_ total: String?)
}

//View -> Presenter
protocol CashPresenterProtocol {
    func viewDidApepar(type: CashType)
    func presentCashCategory(price: String, type: CashType)
    func savedModel(_ model: CashModel)
    func deletedModel(_ model: CashModel)
}

//Presenter - Interactor
protocol CashInteractorProtocol {
    func getTotalCash(type: CashType) -> Decimal
}

//Presenter - WireFrame
protocol CashWireFrameProtocol {
    func cashCategory(from view: CashViewControllerProtocol?, model: CashModel, delegate: CashFlowCategoryDelegate?)
}
