//
//  DIResolver+Settings.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsDIResolver
extension DIResolver {
  // Settings
  func settingsViewCotnroller() -> UIViewController {
    let view = SettingsViewController()
    let interactor = SettingsInteractor()
    let wireFrame = SettingsWireFrame(resolver: self)
    let presenter = SettingsPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
    view.presenter = presenter
    return view
  }

  // Language
  func languageViewController(title: String) -> UIViewController {
    let interactor = LanguageInteractor()
    return self.singleSelectionTableViewCotnroller(title: title, interactor: interactor)
  }

  // Currency
  func currencyViewController(title: String) -> UIViewController {
    let interactor = CurrencyInteractor()
    return self.singleSelectionTableViewCotnroller(title: title, interactor: interactor)
  }

  func aboutProgramController() -> UIViewController {
    let view = AboutProgramViewController()
    let interactor = AboutProgramInteractor()
    let wireFrame = AboutProgramWireFrame(resolver: self)
    let presenter = AboutProgramPresenter(view: view, wireFrame: wireFrame, interactor: interactor)
    view.presenter = presenter
    return view
  }
}
