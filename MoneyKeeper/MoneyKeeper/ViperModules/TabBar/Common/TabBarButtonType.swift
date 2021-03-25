//
//  TabBarButtonType.swift
//  MoneyKeeper
//
//  Created by y.zavyalov on 25.03.2021.
//

import UIKit

enum TabBarButtonType: Int, CaseIterable {
  case cash = 0
  case cashDetail = 1
  case cards = 2
  case goal = 3

  var color: UIColor {
    switch self {
    case .cash:
      return .darkViolet
    case .cashDetail:
      return .plainGray
    case .cards:
      return .blueGray
    case .goal:
      return .plainPurple
    }
  }

  /// Image for tabbar button
  var image: UIImage? {
    switch self {
    case .cash:
      return UIImage(named: "CashFlow")
    case .cashDetail:
      return UIImage(named: "CashFlowDetail")
    case .cards:
      return UIImage(named: "Cards")
    case .goal:
      return UIImage(named: "Goal")
    }
}

  /// Selected image for tabbar button
  var selectedImage: UIImage? {
    switch self {
    case .cash:
      return UIImage(named: "CashFlowBlack")
    case .cashDetail:
      return UIImage(named: "CashFlowDetailBlack")
    case .cards:
      return UIImage(named: "CardsBlack")
    case .goal:
      return UIImage(named: "GoalBlack")
    }
  }

  var tag: Int {
    switch self {
    case .cash:
      return 100
    case .cashDetail:
      return 101
    case .cards:
      return 102
    case .goal:
      return 103
    }
  }
}

