//
//  CashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashPresenter
class CashPresenterImp {
    
  //Properties
  private weak var view: CashView?
  private let interactor: CashInteractor
  private let wireFrame: CashWireFrame
  
  private var totalPrice = Decimal(0)
  
  //Init
  init(view: CashView?, interactor: CashInteractor, wireFrame: CashWireFrame) {
    self.view = view
    self.interactor = interactor
    self.wireFrame = wireFrame
  }
}

// MARK: - CashPresenter
extension CashPresenterImp: CashPresenter {
    
  /// Update total price from cash models
  func viewDidApepar(type: CashType) {
    totalPrice = interactor.getTotalCash(type: type)
    view?.setTotalPrice(totalPrice.toString(.currency))
  }
  
  /// Choose cash category
  func presentCashCategory(price: String, type: CashType) {
//    let model = CashModel(type: type)
//    if let decimalPrice = Decimal(string: price) {
//        model.price = decimalPrice
//    }
//    wireFrame.cashCategory(from: view, model: model, delegate: self)
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

//// MARK: - CashFlowCategoryDelegate
//extension CashPresenterImp: CashFlowCategoryDelegate {
//
//  func clearPrice() {
//    view?.dropPrice()
//  }
//}
