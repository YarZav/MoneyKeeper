//
//  CashWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashWireFrame
class CashWireFrame: BaseWireFrame { }

// MARK: - CashWireFrameProtocol
extension CashWireFrame: CashWireFrameProtocol {
    
    /// Present controller to choose category
    func cashCategory(from view: CashViewControllerProtocol?, model: CashModel, delegate: CashFlowCategoryDelegate?) {
        guard let viewController = view as? UIViewController else { return }
        let cashFlowDetail = self.resolver.cashFlowCategoryViewCotnroller(model: model, delegate: delegate)
        viewController.navigationController?.pushViewController(cashFlowDetail, animated: true)
    }
}

