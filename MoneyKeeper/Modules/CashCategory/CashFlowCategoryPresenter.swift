//
//  CashFlowCategoryPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import UIKit
import YZNotificationView
import Business

// MARK: - CashFlowCategoryDelegate
protocol CashFlowCategoryDelegate: AnyObject {
    func clearPrice()
}

// MARK: - CashFlowPresenter
class CashFlowCategoryPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowCategoryViewControllerProtocol?
    private let interactor: CashFlowCategoryInteractorProtocol
    private let wireFrame: CashFlowCategoryWireFrameProtocol
    public weak var delegate: CashFlowCategoryDelegate?
    
    //Init
    init(view: CashFlowCategoryViewControllerProtocol, interactor: CashFlowCategoryInteractorProtocol, wireFrame: CashFlowCategoryWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    override func languageChanged() {
        self.view?.updateStringLocalization()
    }
}

// MARK: - CashFlowCategoryPresenterProtocol
extension CashFlowCategoryPresenter: CashFlowCategoryPresenterProtocol {
    
    func viewDidLoad(type: CashType) {
//        let items = self.interactor.getCategoryItems()
//        self.view?.setItems(items)
        
//        let total = self.interactor.getTotalCashFlow(type: type)
//        self.view?.setTotalPrice(total.toString(.currency))
    }
    
    func presentCashFlowDetailCategory(transition: CashFlowCategoryTransitionDelegate) {
        self.wireFrame.cashFlowCategoryDetail(from: self.view, delegate: self, transition: transition)
    }
    
    func saveCashFlowModel(_ model: CashModel) {
//        self.interactor.saveCashFlowModel(model) { [weak self] (error) in
//            guard let self = self else { return }
//            Thread.current.doInMainThread {
//                if let error = error {
//                    self.view?.showOkAlertController(title: "CashFlowCategoryWarning".localized(), message: error.localizedDescription, handler: { })
//                } else {
//                    let title = model.categoryModel.title.localized() + ": " + model.getPriceAsString(numberStyle: .currency)
//                    let image = UIImage(named: model.categoryModel.imageName)
//                    self.view?.showNotificationView(title: title, image: image)
//                    self.delegate?.clearPrice()
//                    self.wireFrame.popViewController(from: self.view)
//                }
//            }
//        }
    }
    
    func presentAddCategory() {
        self.wireFrame.presentAddCategory(from: self.view, delegate: self)
    }
}

// MARK: - CashFlowCategoryDetailPresenterDelegate
extension CashFlowCategoryPresenter: CashFlowCategoryDetailPresenterDelegate {
    
//    func didDeleteCategoryModel(_ model: CategoryModel) {
//        self.view?.deleteItems([model])
//    }
}

// MARK: - CashFlowCategoryAddDelegate
extension CashFlowCategoryPresenter: CashFlowCategoryAddDelegate {
    
//    func didAddCategoryModel(_ model: CategoryModel) {
//        self.view?.insertItems([model])
//    }
}
