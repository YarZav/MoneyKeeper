//
//  CashFlowDetailProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import YZBarChart

//Presenter -> View
protocol CashFlowDetailViewControllerProtocol: BaseViewControllerProtocol {
    func updateStringLocalization()
    func createNoContentView()
    func createContentView()
    func displayGraphic(models: [CashModel], barModels: [YZBarViewModel])
    func insertTable(models: [CashModel])
    func deleteTable(models: [CashModel])
}

//View -> Presenter
protocol CashFlowDetailPresenterProtocol {
    func viewDidLoad(by period: PeriodType, type: CashType)
    func updateModels(by period: PeriodType, type: CashType)
    func insertModel(_ model: CashModel, periodType: PeriodType, type: CashType)
    func deleteModel(_ model: CashModel, period: PeriodType, type: CashType)
}

//Presenter - Interactor
protocol CashFlowDetailInteractorProtocol {
    func getCashFlowDetails(type: CashType) -> [CashModel]
    func deleteModel(_ model: CashModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CashFlowDetailWireFrameProtocol { }
