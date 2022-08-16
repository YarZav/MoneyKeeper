//
//  CashProtocols.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Service

// INPUT & OUTPUT
public protocol CashProtocol: CashInputProtocol & CashOutputProtool { }

// INPUT
public protocol CashInputProtocol { }

// OUTPUT
public protocol CashOutputProtool {

  var category: ((CashModel, (() -> Void)?) -> Void)? { get set }

}

// PRESENTER -> VIEW
protocol CashViewProtocol: AnyObject {

  func dropPrice()
  func setTotalPrice(_ price: String?)
  func presentCategory(with cashModel: CashModel)

}

// VIEW -> PRESENTER
protocol CashPresenterProtocol {

  func viewDidApepar()
  func didTapNext(with price: String?)

}

// PRESENTER - INTERACTOR
protocol CashInteractorProtocol {

  func getTotalCash() -> Decimal

}
