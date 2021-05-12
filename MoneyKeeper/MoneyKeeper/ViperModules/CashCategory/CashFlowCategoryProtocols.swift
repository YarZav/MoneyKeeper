//
//  CashFlowCategoryProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import UIKit
import Business

//Presenter -> View
protocol CashFlowCategoryViewControllerProtocol: BaseViewControllerProtocol {
    func updateStringLocalization()
    func setTotalPrice(_ total: String?)
//    func setItems(_ items: [CategoryModel])
//    func deleteItems(_ items: [CategoryModel])
//    func insertItems(_ items: [CategoryModel])
}

//View -> Presenter
protocol CashFlowCategoryPresenterProtocol {
    func viewDidLoad(type: CashType)
    func presentCashFlowDetailCategory(transition: CashFlowCategoryTransitionDelegate)
    func saveCashFlowModel(_ model: CashModel)
    func presentAddCategory()
}

//Presenter - Interactor
protocol CashFlowCategoryInteractorProtocol {
//    func getCategoryItems() -> [CategoryModel]
    func saveCashFlowModel(_ model: CashModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CashFlowCategoryWireFrameProtocol {
    func cashFlowCategoryDetail(from view: CashFlowCategoryViewControllerProtocol?, delegate: CashFlowCategoryDetailPresenterDelegate?, transition: CashFlowCategoryTransitionDelegate)
    func popViewController(from view: CashFlowCategoryViewControllerProtocol?)
    func presentAddCategory(from view: CashFlowCategoryViewControllerProtocol?, delegate: CashFlowCategoryAddDelegate?)
}
