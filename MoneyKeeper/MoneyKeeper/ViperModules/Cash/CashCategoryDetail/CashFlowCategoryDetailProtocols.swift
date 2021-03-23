//
//  CashFlowCategoryDetailProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

//Presenter -> View
protocol CashFlowCategoryDetailViewControllerProtocol: class { }

//View -> Presenter
protocol CashFlowCategoryDetailPresenterProtocol {
    func deleteCategoryModel(_ model: CategoryModel)
}

//Presenter - Interactor
protocol CashFlowCategoryDetailInteractorProtocol {
    func deleteCategoryModel(_ model: CategoryModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CashFlowCategoryDetailWireFrameProtocol { }
