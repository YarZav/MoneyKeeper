//
//  CashFlowCategoryDetailPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowCategoryDetailPresenter
class CashFlowCategoryDetailPresenter: BasePresenter {
    
    // Properties
    private weak var view: CashFlowCategoryDetailViewControllerProtocol?
    private let interactor: CashFlowCategoryDetailInteractorProtocol
    private let wireFrame: CashFlowCategoryDetailWireFrameProtocol
    
    // Init
    init(view: CashFlowCategoryDetailViewControllerProtocol, interactor: CashFlowCategoryDetailInteractorProtocol, wireFrame: CashFlowCategoryDetailWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowCategoryDetailPresenterProtocol
extension CashFlowCategoryDetailPresenter: CashFlowCategoryDetailPresenterProtocol { }
