//
//  TabBarButtonType.swift
//  MoneyKeeper
//
//  Created by y.zavyalov on 25.03.2021.
//

enum TabBarType {

  case cash
  case cashDetail

  var image: UIImage? {
    switch self {
    case .cash:
      return UIImage.banknote
    case .cashDetail:
      return UIImage.docText
    }
  }

}
