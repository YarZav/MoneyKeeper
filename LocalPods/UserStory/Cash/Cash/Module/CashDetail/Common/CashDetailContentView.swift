//
//  CashDetailContentView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import YZBarChart
import DesignSystem

protocol CashDetailContentViewDelegate: AnyObject {

  func didChangePeriod(by period: CashDetailPeriodType)

}

enum CashDetailViewType: Int {

  case graphic = 0        //Show graphic
  case table = 1          //Show table

}

final class CashDetailContentView: UIView {

  // MARK: - Contants

  private enum Constants {
    static let graphicHeight: CGFloat = 200
  }

  // MARK: - Private property

  private lazy var periodView: CashDetailPeriodsView = {
    let view = CashDetailPeriodsView(selectedPeriod: .week)
    view.delegate = self
    return view
  }()

  private let graphicView = CashDetailGraphicView()
  private let tableView = CashDetailTableView()
  private var viewType: CashDetailViewType = .graphic

  // MARK: - Internal property

  weak var delegate: CashDetailContentViewDelegate?

  // MARK: - Init

  init() {
    super.init(frame: .zero)

    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(periodType: CashDetailPeriodType) {
    super.init(frame: .zero)

    createUI()
  }

}

// MARK: - Internal

extension CashDetailContentView {

  func displayGraphic(barModels: [YZBarViewModel], models: [CashModel]) {
    graphicView.displayBarViewModels(barModels)
  }
  
  func insertTable(models: [CashModel]) {
    tableView.insertModels(models)
  }

}

// MARK: - Private

private extension CashDetailContentView {

  func createUI() {
    addSubview(periodView)
    addSubview(graphicView)
    addSubview(tableView)

    periodView.translatesAutoresizingMaskIntoConstraints = false
    graphicView.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      periodView.topAnchor.constraint(equalTo: topAnchor),
      periodView.leftAnchor.constraint(equalTo: leftAnchor),
      periodView.rightAnchor.constraint(equalTo: rightAnchor),
      periodView.heightAnchor.constraint(equalToConstant: DesignConstants.Height.plain),

      graphicView.topAnchor.constraint(equalTo: periodView.bottomAnchor),
      graphicView.leftAnchor.constraint(equalTo: leftAnchor),
      graphicView.rightAnchor.constraint(equalTo: rightAnchor),
      graphicView.heightAnchor.constraint(equalToConstant: Constants.graphicHeight),

      tableView.topAnchor.constraint(equalTo: graphicView.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])

  }

}

// MARK: - CashDetailContentViewDelegate

extension CashDetailContentView: CashDetailPeriodsViewDelegate {

  func didSelectPeriod(_ period: CashDetailPeriodType) {
    let newViewType: CashDetailViewType = (period == .all) ? .table : .graphic
    if newViewType == viewType {
      delegate?.didChangePeriod(by: period)
    } else {
      viewType = newViewType
      delegate?.didChangePeriod(by: period)
    }
  }

}
