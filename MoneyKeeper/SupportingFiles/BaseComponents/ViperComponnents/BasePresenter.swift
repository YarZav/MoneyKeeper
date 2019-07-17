//
//  BasePresenter.swift
//  MoneyKeeper
//
//  Created by admin on 19.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - BasePresenter
class BasePresenter {
    
    // Init
    init() {
        self.addObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Actions
extension BasePresenter {
    
    @objc func languageChanged() {
        //Override this method if needed
    }
    
    @objc func userDataReset() {
        //Override this method if needed
    }
}

// MARK: - Privates
extension BasePresenter {
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: Notification.Name("AppLanguageChanging"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userDataReset), name: Notification.Name("ClearUserData"), object: nil)

    }
}
