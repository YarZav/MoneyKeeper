//  
//  Localized.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

extension String {

  func localized(_ table: String = "Localization") -> String {
    let bundle = Bundle.tabBarBundle
    let localzedString = NSLocalizedString(self, tableName: table, bundle: bundle, comment: self)
    assert(localzedString != self, "\(self) localized string is nil")
    return localzedString
  }

}
