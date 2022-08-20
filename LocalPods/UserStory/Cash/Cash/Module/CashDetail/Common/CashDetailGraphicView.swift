//
//  CashDetailGraphicView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import YZBarChart
import DesignSystem

final class CashDetailGraphicView: UIView {

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
extension CashDetailGraphicView {

  func displayBarViewModels(_ viewModels: [YZBarViewModel]) {
      barChartView.displayViewModels(viewModels, animated: true)
  }

}

// MARK: - Private

private extension CashDetailGraphicView {

  func createUI() {
    var configuration = YZBarChartViewConfiguration()
    configuration.separateLineColor = .blueGray
    barChartView = YZBarChartView(configuration: configuration)

    addSubview(barChartView)

    barChartView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      barChartView.topAnchor.constraint(equalTo: topAnchor),
      barChartView.bottomAnchor.constraint(equalTo: bottomAnchor),
      barChartView.leftAnchor.constraint(equalTo: leftAnchor, constant: DesignConstants.Margin.plain),
      barChartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -DesignConstants.Margin.plain)
    ])
  }

}
