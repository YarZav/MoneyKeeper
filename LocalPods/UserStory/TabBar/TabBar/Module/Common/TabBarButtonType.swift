//
//  TabBarButtonType.swift
//  MoneyKeeper
//
//  Created by y.zavyalov on 25.03.2021.
//

import UIKit
import DesignSystem
import Extension

enum TabBarButtonType: Int, CaseIterable {

  case cash = 0
  case cashDetail = 1

  var image: UIImage? {
    switch self {
    case .cash:
      let image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .plainGray)
    case .cashDetail:
      let image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .plainGray)
    }
  }

  var selectedImage: UIImage? {
    switch self {
    case .cash:
      let image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .white)
    case .cashDetail:
      let image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .white)
    }
  }

}
