//
//  LaunchPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarPresenter
class LaunchPresenter: BasePresenter {
    
    //Properties
    private weak var view: LaunchViewControllerProtocol?
    private let interactor: LaunchInteractorProtocol
    private let wireFrame: LaunchWireFrameProtocol
    
    //Init
    init(view: LaunchViewControllerProtocol, interactor: LaunchInteractorProtocol, wireFrame: LaunchWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - LaunchPresenterProtocol
extension LaunchPresenter: LaunchPresenterProtocol {
    
    func viewLoaded() {
        self.interactor.createUserAccount { [weak self] (error) in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.view?.showOkAlertController(title: "LaunchWarning".localized(), message: error.localizedDescription, handler: { })
            } else {
                strongSelf.wireFrame.presentTabbarController()
            }
        }
    }
}
