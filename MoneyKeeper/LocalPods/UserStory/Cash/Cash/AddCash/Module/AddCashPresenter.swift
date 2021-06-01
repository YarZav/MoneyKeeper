//
//  AddCashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - AddCashPresenter
final class AddCashPresenterImp {
    
  //Properties
  private weak var view: AddCashView?
  private let interactor: AddCashInteractor
  private let wireFrame: AddCashWireFrame
  
  private var totalPrice = Decimal(0)
  
  //Init
  init(view: AddCashView?, interactor: AddCashInteractor, wireFrame: AddCashWireFrame) {
    self.view = view
    self.interactor = interactor
    self.wireFrame = wireFrame
  }
}

// MARK: - CashPresenter
extension AddCashPresenterImp: AddCashPresenter {
    
  /// Update total price from cash models
  func viewDidApepar(type: CashType) {
    totalPrice = interactor.getTotalCash(type: type)
//    view?.setTotalPrice(totalPrice.toString(.currency))
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
//    Thread.current.doInMainThread {
//      self.totalPrice += model.price
//      self.view?.setTotalPrice(self.totalPrice.toString(.currency))
//    }
  }
  
  /// Delete cash model
  func deletedModel(_ model: CashModel) {
//    Thread.current.doInMainThread {
//      self.totalPrice -= model.price
//      self.view?.setTotalPrice(self.totalPrice.toString(.currency))
//    }
  }
}

//// MARK: - CashFlowCategoryDelegate
//extension CashPresenterImp: CashFlowCategoryDelegate {
//
//  func clearPrice() {
//    view?.dropPrice()
//  }
//}
