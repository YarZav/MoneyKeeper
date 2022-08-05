//
//  CashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business
import Extension

final class CashPresenterImp {
    
  // MARK: - Private property

  private let interactor: CashInteractor
  private let wireFrame: CashWireFrame
  
  private var totalPrice = Decimal(0)

  // MARK: - Internal property

  weak var view: CashView?

  //MARK: - Init

  init(interactor: CashInteractor, wireFrame: CashWireFrame) {
    self.interactor = interactor
    self.wireFrame = wireFrame
  }

}

// MARK: - CashPresenter

extension CashPresenterImp: CashPresenter {
    
  func viewDidApepar(type: CashType) {
    totalPrice = interactor.getTotalCash(type: type)
    view?.setTotalPrice(totalPrice.toString(.currency))
  }
  
  func presentCategory(price: String, type: CashType) {
    guard let priceDouble = price.toDouble() else { return }
    let priceDecimal = Decimal(priceDouble)
    let cashModel = CashModel(type: type, price: priceDecimal)
    wireFrame.pushCashCategory(from: view, cashModel: cashModel)
  }

}
