//
//  LanguageFactory.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

/// language code
enum LanguageCode: Int, CaseIterable {
    
    /// Russian language
    case russian = 0
    
    /// Application code of language
    var code: String {
        switch self {
        case .russian: return "ru"
        }
    }
    
    /// Title for language
    var title: String {
        switch self {
        case .russian: return "Русский"
        }
    }
}

// MARK: - Publics
class LanguageFactory {
    
    /// Get all languages
    public static func models() -> [LanguageModel] {
        return LanguageCode.allCases.compactMap { LanguageModel(isOn: false, code: $0) }
    }
}
