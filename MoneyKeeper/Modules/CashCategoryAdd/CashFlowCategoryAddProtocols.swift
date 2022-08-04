//
//  CashFlowCategoryAddProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 20/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

//Presenter -> View
protocol CashFlowCategoryAddViewControllerProtocol: BaseViewControllerProtocol {
    func setItems(_ items: [String])
}

//View -> Presenter
protocol CashFlowCategoryAddPresenterProtocol {
    func viewLoaded()
    func saveCategoryModel(title: String?, imageName: String?)
}

//Presenter - Interactor
protocol CashFlowCategoryAddInteractorProtocol {
//    func getImageNamed() -> [String]
//    func saveCategory(_ model: CategoryModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CashFlowCategoryAddWireFrameProtocol {
    func popViewController(from view: CashFlowCategoryAddViewControllerProtocol?)
}
