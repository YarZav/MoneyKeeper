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
protocol CashFlowCategoryViewControllerProtocol: class {
    func setItems(_ items: [ServiceModel])
    func succedSave()
}

//View -> Presenter
protocol CashFlowCategoryPresenterProtocol {
    func viewDidLoad()
    func cashFlowDetailCategory(transition: CashFlowCategoryTransitionDelegate, model: CashFlowModel)
    func saveCashFlowModel(_ model: CashFlowModel)
    func popViewController()
}

//Presenter - Interactor
protocol CashFlowCategoryInteractorProtocol {
    func getCategoryItems() -> [ServiceModel]
    func saveCashFlowModel(_ model: CashFlowModel)
}

//Presenter - WireFrame
protocol CashFlowCategoryWireFrameProtocol {
    func cashFlowCategoryDetail(from view: CashFlowCategoryViewControllerProtocol?, transition: CashFlowCategoryTransitionDelegate, model: CashFlowModel)
    func popViewController(from view: CashFlowCategoryViewControllerProtocol?)
}
