//  
//  SettingsWireFrame.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsWireFrame
class SettingsWireFrame: BaseWireFrame { }

// MARK: - SettingsWireFrameProtocol
extension SettingsWireFrame: SettingsWireFrameProtocol {
    
    func presentLanguageViewController(from view: SettingsViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let languageVC = self.resolver.languageViewController(title: "Language")
        view.navigationController?.pushViewController(languageVC, animated: true)
    }
    
    func presentCurrencyViewController(from view: SettingsViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let currencyVC = self.resolver.currencyViewController(title: "Currency")
        view.navigationController?.pushViewController(currencyVC, animated: true)
    }
    
    func presentAboutProgramController(from view: SettingsViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let aboutProgramVC = self.resolver.aboutProgramController()
        view.navigationController?.pushViewController(aboutProgramVC, animated: true)
    }
}
