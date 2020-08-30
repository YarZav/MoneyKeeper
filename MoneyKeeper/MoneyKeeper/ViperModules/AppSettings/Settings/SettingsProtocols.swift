//  
//  SettingsProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

/// Sections for settings
enum SettingsSections: Int, CaseIterable {
    case general = 0
    case storage = 1
    case security = 2
    case other = 3
    
    var title: String {
        switch self {
        case .general: return "SettingsGeneral".localized()
        case .storage: return "SettingsStorage".localized()
        case .security: return "SettingsSecurity".localized()
        case .other: return "SettingsOther".localized()
        }
    }
}

/// Rows for general section
enum SettingsGeneralRows: Int, CaseIterable {
    case language = 0
    case currency = 1
    case push = 2
    
    var title: String {
        switch self {
        case .language: return "SettingsLanguage".localized()
        case .currency: return "SettingsCurrency".localized()
        case .push: return "SettingsPush".localized()
        }
    }
    
    var color: UIColor {
        switch self {
        case .language: return UIColor.rgb(red: 0, green: 128, blue: 0)
        case .currency: return UIColor.rgb(red: 46, green: 139, blue: 87)
        case .push: return UIColor.rgb(red: 107, green: 142, blue: 35)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .language: return UIImage(named: "LanguageSettings")
        case .currency: return UIImage(named: "CurrencySettings")
        case .push: return UIImage(named: "PushSettings")
        }
    }
}

/// Rows for storage section
enum SettingsStorageRows: Int, CaseIterable {
    case iCloud = 0
    case delete = 1
    
    var title: String {
        switch self {
        case .iCloud: return "SettingsiCloud".localized()
        case .delete: return "SettingsClean".localized()
        }
    }
    
    var color: UIColor {
        switch self {
        case .iCloud: return UIColor.rgb(red: 0, green: 0, blue: 128)
        case .delete: return UIColor.rgb(red: 72, green: 61, blue: 139)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .iCloud: return UIImage(named: "iCloudSettings")
        case .delete: return UIImage(named: "DeleteSettings")
        }
    }
}

/// Rows for security section
enum SettingsSecurityRows: Int, CaseIterable {
    case pinCode = 0
    case touchID = 1
    
    var title: String {
        switch self {
        case .pinCode: return "SettingsPinCode".localized()
        case .touchID: return "SettingsTouchID".localized()
        }
    }
    
    var color: UIColor {
        switch self {
        case .pinCode: return UIColor.rgb(red: 160, green: 82, blue: 45)
        case .touchID: return UIColor.rgb(red: 210, green: 105, blue: 30)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .pinCode: return UIImage(named: "PinCodeSettings")
        case .touchID: return UIImage(named: "TouchIDSettings")
        }
    }
}

/// Rows for other section
enum SettingsOtherRows: Int, CaseIterable {
    case about = 0
    case review = 1
    case hint = 2
    
    var title: String {
        switch self {
        case .about: return "SettingsAbout".localized()
        case .review: return "SettingsReview".localized()
        case .hint: return "SettingsHint".localized()
        }
    }
    
    var color: UIColor {
        switch self {
        case .about: return UIColor.rgb(red: 128, green: 128, blue: 128)
        case .review: return UIColor.rgb(red: 160, green: 160, blue: 160)
        case .hint: return UIColor.rgb(red: 190, green: 190, blue: 190)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .about: return UIImage(named: "AboutSettings")
        case .review: return UIImage(named: "ReviewSettings")
        case .hint: return UIImage(named: "HintSetings")
        }
    }
}

// VIEW -> PRESENTER
protocol SettingsPresenterProtocol: class {
    func presentLanguage()
    func presentCurrency()
    func presentAboutProgram()
    func enabledlocalPush(_ enabled: Bool)
    func clearUserData()
}

// PRESENTER -> VIEW
protocol SettingsViewProtocol: BaseViewControllerProtocol {
    func updateLocalizedString()
}

// PRESENTER -> WIREFRAME
protocol SettingsWireFrameProtocol: class {
    func presentLanguageViewController(from view: SettingsViewProtocol?)
    func presentCurrencyViewController(from view: SettingsViewProtocol?)
    func presentAboutProgramController(from view: SettingsViewProtocol?)
}

// INTERACTOR -> PRESENTER
protocol SettingsInteractorProtocol: class {
    func enabledlocalPush(_ enabled: Bool, callback: @escaping (Error?) -> Void)
    func clearUserData(callback: @escaping (Error?) -> Void)
}
