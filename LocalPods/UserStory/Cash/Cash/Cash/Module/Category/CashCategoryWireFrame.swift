//
//  CashCategoryWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

final class CashCategoryWireFrame { }

// MARK: - CashCategoryWireFrameProtocol

extension CashCategoryWireFrame: CashCategoryWireFrameProtocol {

  func popViewController(from view: CashCategoryViewProtocol?) {
    guard let viewController = view as? UIViewController else { return }
    viewController.navigationController?.popViewController(animated: true)
    
  }

}
