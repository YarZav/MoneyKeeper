//
//  AddCash.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business

// Presenter -> View
protocol AddCashView: AnyObject {
  var presenter: AddCashPresenter! { get set }
  func updateStringLocalization()
  func dropPrice()
  func setTotalPrice(_ total: String?)
}

// View -> Presenter
protocol AddCashPresenter {
  func viewDidApepar(type: CashType)
  func presentCashCategory(price: String, type: CashType)
  func savedModel(_ model: CashModel)
  func deletedModel(_ model: CashModel)
}

// Presenter - Interactor
protocol AddCashInteractor {
  func getTotalCash(type: CashType) -> Decimal
}

// Presenter - WireFrame
protocol AddCashWireFrame {
//  func cashCategory(from view: CashView?, model: CashModel, delegate: CashFlowCategoryDelegate?)
}
