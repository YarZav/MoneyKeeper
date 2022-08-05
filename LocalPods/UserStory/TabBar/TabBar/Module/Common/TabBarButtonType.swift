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

  var color: UIColor {
    switch self {
    case .cash:
      return .darkViolet
    }
  }

  /// Image for tabbar button
  var image: UIImage? {
    switch self {
    case .cash:
      let image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .plainGray)
    }
  }

  /// Selected image for tabbar button
  var selectedImage: UIImage? {
    switch self {
    case .cash:
      let image = UIImage(systemName: "banknote")?.withRenderingMode(.alwaysTemplate)
      return image?.maskWithColor(color: .white)
    }
  }

}
