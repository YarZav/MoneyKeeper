//
//  CashFlowCategoryWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowWireFrame
class CashFlowCategoryWireFrame: BaseWireFrame { }

// MARK: - CashFlowCategoryWireFrameProtocol
extension CashFlowCategoryWireFrame: CashFlowCategoryWireFrameProtocol {
    
    func cashFlowCategoryDetail(from view: CashFlowCategoryViewControllerProtocol?, transition: CashFlowCategoryTransitionDelegate, model: CashFlowModel) {
        guard let viewController = view as? UIViewController else { return }
        let detailViewController = self.resolver.cashFlowCategoryDetailViewController(model: model)
        detailViewController.transitioningDelegate = transition
        detailViewController.modalPresentationStyle = .custom
        viewController.present(detailViewController, animated: true) { }
    }
    
    func popViewController(from view: CashFlowCategoryViewControllerProtocol?) {
        guard let viewController = view as? UIViewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
}
