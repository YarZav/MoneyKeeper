//
//  CashWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Business

final class CashWireFrameImp {

    private let cashCategoryView: CashCategoryViewProtocol

    init(cashCategoryView: CashCategoryViewProtocol) {
        self.cashCategoryView = cashCategoryView
    }

}

// MARK: - CashWireFrame

extension CashWireFrameImp: CashWireFrame {

  func pushCashCategory(from view: CashView?, cashModel: CashModel) {
    cashCategoryView.cashModel = cashModel

    guard let fromViewController = view as? UIViewController else { return }
    guard let toViewController = cashCategoryView as? UIViewController else { return }
    fromViewController.navigationController?.pushViewController(toViewController, animated: true)
  }
}
