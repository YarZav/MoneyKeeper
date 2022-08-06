//
//  Cash.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business

// Presenter -> View
public protocol CashView: AnyObject {

  func dropPrice()
  func setTotalPrice(_ total: String?)

}

// View -> Presenter
protocol CashPresenter {

  func viewDidApepar()
  func presentCategory(price: String)

}

// Presenter - Interactor
protocol CashInteractor {

  func getTotalCash() -> Decimal

}

// Presenter - WireFrame
protocol CashWireFrame {

  func pushCashCategory(from view: CashView?, cashModel: CashModel,  delegate: CashCategoryViewDelegate?)

}
