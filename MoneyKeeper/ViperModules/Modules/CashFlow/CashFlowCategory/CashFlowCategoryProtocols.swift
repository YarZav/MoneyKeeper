//
//  CashFlowCategoryProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import UIKit

//Presenter -> View
protocol CashFlowCategoryViewControllerProtocol: BaseViewControllerProtocol {
    func updateStringLocalization()
    func setTotalPrice(_ total: String?)
    func setItems(_ items: [CategoryModel])
    func deleteItems(_ items: [CategoryModel])
    func insertItems(_ items: [CategoryModel])
}

//View -> Presenter
protocol CashFlowCategoryPresenterProtocol {
    func viewDidLoad(type: CashFlowType)
    func presentCashFlowDetailCategory(transition: CashFlowCategoryTransitionDelegate)
    func saveCashFlowModel(_ model: CashFlowModel)
    func presentAddCategory()
}

//Presenter - Interactor
protocol CashFlowCategoryInteractorProtocol {
    func getCategoryItems() -> [CategoryModel]
    func saveCashFlowModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void)
    func getTotalCashFlow(type: CashFlowType) -> Decimal
}

//Presenter - WireFrame
protocol CashFlowCategoryWireFrameProtocol {
    func cashFlowCategoryDetail(from view: CashFlowCategoryViewControllerProtocol?, delegate: CashFlowCategoryDetailPresenterDelegate?, transition: CashFlowCategoryTransitionDelegate)
    func popViewController(from view: CashFlowCategoryViewControllerProtocol?)
    func presentAddCategory(from view: CashFlowCategoryViewControllerProtocol?, delegate: CashFlowCategoryAddDelegate?)
}
