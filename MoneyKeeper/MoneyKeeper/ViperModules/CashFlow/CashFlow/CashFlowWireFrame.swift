//
//  CashFlowWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowWireFrame
class CashFlowWireFrame: BaseWireFrame { }

// MARK: - CashFlowWireFrameProtocol
extension CashFlowWireFrame: CashFlowWireFrameProtocol {
    
    /// Present controller to choose category
    func cashFlowCategory(from view: CashFlowViewControllerProtocol?, model: CashFlowModel, delegate: CashFlowCategoryDelegate?) {
        guard let viewController = view as? UIViewController else { return }
        let cashFlowDetail = self.resolver.cashFlowCategoryViewCotnroller(model: model, delegate: delegate)
        viewController.navigationController?.pushViewController(cashFlowDetail, animated: true)
    }
}

