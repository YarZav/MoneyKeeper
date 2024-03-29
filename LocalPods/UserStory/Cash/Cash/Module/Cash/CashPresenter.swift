//
//  CashPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Service

final class CashPresenter {
    
  // MARK: - Private property

  private let interactor: CashInteractorProtocol

  // MARK: - Internal property

  weak var view: CashViewProtocol?

  //MARK: - Init

  init(interactor: CashInteractorProtocol) {
    self.interactor = interactor
  }

}

// MARK: - CashPresenterProtocol

extension CashPresenter: CashPresenterProtocol {

  func viewDidApepar() {
    let totalPrice = interactor.getTotalCash()
    view?.setTotalPrice(totalPrice)
  }

  func didTapNext(with price: String?) {
    guard let priceDouble = price?.toDouble else {
      fatalError("Can not convert input price String to Double")
    }
    let priceDecimal = Decimal(priceDouble)
    let cashModel = CashModel(type: .outcome, price: priceDecimal)
    view?.presentCategory(with: cashModel)
  }

}
