//
//  CashType.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 8/4/22.
//

public enum CashType: Int {

  // Расходы
  case outcome

  // Доходы
  case income

  public var title: String {
    switch self {
    case .outcome:
      return NSLocalizedString("Outcom", comment: "The name of the outcom")
    case .income:
      return NSLocalizedString("Incom", comment: "The name of the outcom")
    }
  }
}
