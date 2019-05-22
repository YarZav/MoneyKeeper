//
//  CashFlowDetailProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

//Presenter -> View
protocol CashFlowDetailViewControllerProtocol: class {
    func createNoContentView()
    func createContentView()
    func displayContent(models: [CashFlowModel], barModels: [BarViewModel])
}

//View -> Presenter
protocol CashFlowDetailPresenterProtocol {
    func updateModels(by period: PeriodType)
    func deleteModel(_ model: CashFlowModel)
}

//Presenter - Interactor
protocol CashFlowDetailInteractorProtocol {
    func getCashFlowDetails() -> [CashFlowModel]
    func deleteModel(_ model: CashFlowModel)
}

//Presenter - WireFrame
protocol CashFlowDetailWireFrameProtocol { }
