//
//  CashFlowCategoryAddWireFrame.swift
//  MoneyKeeper
//
//  Created by admin on 20/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowCategoryAddWireFrame
class CashFlowCategoryAddWireFrame: BaseWireFrame { }

// MARK: - CashFlowCategoryAddWireFrameProtocol
extension CashFlowCategoryAddWireFrame: CashFlowCategoryAddWireFrameProtocol {
    
    func popViewController(from view: CashFlowCategoryAddViewControllerProtocol?) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
