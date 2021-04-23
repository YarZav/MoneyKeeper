//
//  CashFlowCategoryAddPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 20/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashFlowCategoryAddDelegate
protocol CashFlowCategoryAddDelegate: class {
    func didAddCategoryModel(_ model: CategoryModel)
}

// MARK: - CashFlowCategoryAddPresenter
class CashFlowCategoryAddPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowCategoryAddViewControllerProtocol?
    private let interactor: CashFlowCategoryAddInteractorProtocol
    private let wireFrame: CashFlowCategoryAddWireFrameProtocol
    public weak var delegate: CashFlowCategoryAddDelegate?
    
    //Init
    init(view: CashFlowCategoryAddViewControllerProtocol, interactor: CashFlowCategoryAddInteractorProtocol, wireFrame: CashFlowCategoryAddWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowCategoryAddPresenterProtocol
extension CashFlowCategoryAddPresenter: CashFlowCategoryAddPresenterProtocol {
    
    func viewLoaded() {
        let items = self.interactor.getImageNamed()
        self.view?.setItems(items)
    }
    
    func saveCategoryModel(title: String?, imageName: String?) {
        guard let title = title, !title.isEmpty else {
            self.view?.showNotificationView(title: "CashFlowCategoryAddEnterName".localized(), image: nil)
            return
        }
        
        guard let imageName = imageName, !imageName.isEmpty else {
            self.view?.showNotificationView(title: "CashFlowCategoryAddChooseImage".localized(), image: nil)
            return
        }
        
//        let categoryModel = CategoryModel(title: title, imageName: imageName)
//        self.interactor.saveCategory(categoryModel) { (error) in
//            Thread.current.doInMainThread {
//                if let error = error {
//                    self.view?.showOkAlertController(title: "CashFlowCategoryAddWarning".localized(), message: error.localizedDescription, handler: { })
//                } else {
//                    self.delegate?.didAddCategoryModel(categoryModel)
//                    self.wireFrame.popViewController(from: self.view)
//                }
//            }
//        }
    }
}
