//
//  AddCashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business
import Extension

final class AddCashPresenterImp {
    
  // MARK: - Private property

  private let interactor: AddCashInteractor
  private let wireFrame: AddCashWireFrame
  
  private var totalPrice = Decimal(0)

  // MARK: - Internal property

  weak var view: AddCashView?

  //MARK: - Init

  init(interactor: AddCashInteractor, wireFrame: AddCashWireFrame) {
    self.interactor = interactor
    self.wireFrame = wireFrame
  }

}

// MARK: - CashPresenter

extension AddCashPresenterImp: AddCashPresenter {
    
  func viewDidApepar(type: CashType) {
    totalPrice = interactor.getTotalCash(type: type)
    view?.setTotalPrice(totalPrice.toString(.currency))
  }
  
  func presentCashCategory(price: String, type: CashType) { }
  
  func savedModel(_ model: CashModel) { }
  
  func deletedModel(_ model: CashModel) { }

}
