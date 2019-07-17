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
    func displayGraphic(models: [CashFlowModel], barModels: [YZBarViewModel])
    func insertTable(models: [CashFlowModel])
    func deleteTable(models: [CashFlowModel])
}

//View -> Presenter
protocol CashFlowDetailPresenterProtocol {
    func viewDidLoad(by period: PeriodType, type: CashFlowType)
    func updateModels(by period: PeriodType, type: CashFlowType)
    func insertModel(_ model: CashFlowModel, periodType: PeriodType, type: CashFlowType)
    func deleteModel(_ model: CashFlowModel, period: PeriodType, type: CashFlowType)
}

//Presenter - Interactor
protocol CashFlowDetailInteractorProtocol {
    func addObserver(_ observer: CashFlowManagerDelegate)
    func getCashFlowDetails(type: CashFlowType) -> [CashFlowModel]
    func deleteModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CashFlowDetailWireFrameProtocol { }
