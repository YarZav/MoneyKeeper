//
//  CashType+Extension.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 8/16/22.
//

import Service

extension CashType {

  var title: String {
    switch self {
    case .outcome:
        return "OutcomKey".localized()
    case .income:
        return "IncomKey".localized()
    }
  }

}
