//
//  CashDetailProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import YZBarChart

// INPUT & OUTPUT

public protocol CashDetailProtocol: CashDetailInputProtocol & CashDetailOutputProtocol { }

// INPUT
public protocol CashDetailInputProtocol { }

// OUTPUT

public protocol CashDetailOutputProtocol { }

// PRESENTER -> VIEW
protocol CashDetailViewProtocol: AnyObject {

  func showNoContentView()
  func showContentView()
  func displayGraphic(models: [CashModel], barModels: [YZBarViewModel])
  func insertTable(models: [CashModel])

}

// VIEW -> PRESENTER
protocol CashDetailPresenterProtocol {

  func viewDidLoad(by period: CashDetailPeriodType, type: CashType)
  func prepareForDisplay(by period: CashDetailPeriodType, type: CashType)

}

// PRESENTER - INTERACTOR
protocol CashDetailInteractorProtocol {

  func getCashFlowDetails(type: CashType) -> [CashModel]

}
