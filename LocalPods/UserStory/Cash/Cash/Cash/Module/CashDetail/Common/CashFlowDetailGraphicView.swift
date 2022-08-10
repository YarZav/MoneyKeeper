//
//  CashFlowDetailGraphicView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZBarChart

final class CashFlowDetailGraphicView: UIView {

  // MARK: - Properties

  private var barChartView: YZBarChartView!

  // MARK: - Init

  init() {
    super.init(frame: .zero)

    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

// MARK: - Internal
extension CashFlowDetailGraphicView {

  func displayBarViewModels(_ viewModels: [YZBarViewModel]) {
      barChartView.displayViewModels(viewModels, animated: true)
  }

}

// MARK: - Private

private extension CashFlowDetailGraphicView {

  func createUI() {
    var configuration = YZBarChartViewConfiguration()
    configuration.separateLineColor = .blueGray
    barChartView = YZBarChartView(configuration: configuration)

    addSubview(barChartView)

    barChartView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      barChartView.topAnchor.constraint(equalTo: topAnchor),
      barChartView.bottomAnchor.constraint(equalTo: bottomAnchor),
      barChartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      barChartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
    ])
  }

}
