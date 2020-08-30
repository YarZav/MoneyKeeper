//  
//  SettingsPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsPresenter
class SettingsPresenter: BasePresenter {
    
    private weak var view: SettingsViewProtocol?
    private var wireFrame: SettingsWireFrameProtocol
    private var interactor: SettingsInteractorProtocol
    
    init(view: SettingsViewProtocol, interactor: SettingsInteractorProtocol, wireFrame: SettingsWireFrameProtocol) {
        self.view = view
        self.wireFrame = wireFrame
        self.interactor = interactor
    }
    
    override func languageChanged() {
        self.view?.updateLocalizedString()
    }
}

// MARK: - SettingsPresenterProtocol
extension SettingsPresenter: SettingsPresenterProtocol {
    
    func presentLanguage() {
        self.wireFrame.presentLanguageViewController(from: self.view)
    }
    
    func presentCurrency() {
        self.wireFrame.presentCurrencyViewController(from: self.view)
    }
    
    func presentAboutProgram() {
        self.wireFrame.presentAboutProgramController(from: self.view)
    }
    
    func enabledlocalPush(_ enabled: Bool) {
        self.interactor.enabledlocalPush(enabled) { [weak self] (error) in
            if let error = error {
                self?.view?.showOkAlertController(title: "SettingsWarning".localized(), message: error.localizedDescription, handler: { })
            }
        }
    }
    
    func clearUserData() {
        self.interactor.clearUserData { [weak self] (error) in
            if let error = error {
                self?.view?.showOkAlertController(title: "SettingsWarning".localized(), message: error.localizedDescription, handler: { })
            } else {
                NotificationCenter.default.post(name: Notification.Name("ClearUserData"), object: nil)
            }
        }
    }
}
