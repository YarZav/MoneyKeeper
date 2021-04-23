//
//  CashProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business

//Presenter -> View
protocol CashView: AnyObject {
  func updateStringLocalization()
  func dropPrice()
  func setTotalPrice(_ total: String?)
}

//View -> Presenter
protocol CashPresenter {
  func viewDidApepar(type: CashType)
  func presentCashCategory(price: String, type: CashType)
  func savedModel(_ model: CashModel)
  func deletedModel(_ model: CashModel)
}

//Presenter - Interactor
protocol CashInteractor {
  func getTotalCash(type: CashType) -> Decimal
}

//Presenter - WireFrame
protocol CashWireFrame {
//  func cashCategory(from view: CashView?, model: CashModel, delegate: CashFlowCategoryDelegate?)
}
