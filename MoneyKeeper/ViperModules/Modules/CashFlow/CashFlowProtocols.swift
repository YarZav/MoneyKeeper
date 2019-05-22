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
    func dropPrice()
    func setTotalPrice(_ total: String?)
}

//View -> Presenter
protocol CashFlowPresenterProtocol {
    func viewWillApepar()
    func presentCashFlowCategory(price: String)
}

//Presenter - Interactor
protocol CashFlowInteractorProtocol {
    func getCashFlowModels() -> [CashFlowModel]
}

//Presenter - WireFrame
protocol CashFlowWireFrameProtocol {
    func cashFlowCategory(from view: CashFlowViewControllerProtocol?, model: CashFlowModel, delegate: CashFlowCategoryDelegate?)
}
