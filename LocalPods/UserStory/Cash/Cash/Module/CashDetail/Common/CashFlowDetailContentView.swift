//
//  CashFlowDetailContentView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import YZBarChart

protocol CashDetailContentViewDelegate: AnyObject {

  func didChangePeriod(by period: CashDetailPeriodType)

}

enum CashFlowDetailViewType: Int {

  case graphic = 0        //Show graphic
  case table = 1          //Show table

}

final class CashFlowDetailContentView: UIView {

  // MARK: - Private property

  private lazy var periodView: CashDetailPeriodsView = {
    let view = CashDetailPeriodsView(selectedPeriod: .week)
    view.delegate = self
    return view
  }()

  private let graphicView = CashFlowDetailGraphicView()
  private let tableView = CashDetailTableView()
  private var viewType: CashFlowDetailViewType = .graphic

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

extension CashFlowDetailContentView {

  func displayGraphic(barModels: [YZBarViewModel], models: [CashModel], completion: @escaping () -> Void) {
    graphicView.displayBarViewModels(barModels)
    completion()
  }
  
  func insertTable(models: [CashModel], completion: @escaping () -> Void) {
    tableView.insertModels(models) { completion() }
  }

}

// MARK: - Private

private extension CashFlowDetailContentView {

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
      periodView.heightAnchor.constraint(equalToConstant: 44),

      graphicView.topAnchor.constraint(equalTo: periodView.bottomAnchor),
      graphicView.leftAnchor.constraint(equalTo: leftAnchor),
      graphicView.rightAnchor.constraint(equalTo: rightAnchor),
      graphicView.heightAnchor.constraint(equalToConstant: 200),

      tableView.topAnchor.constraint(equalTo: graphicView.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])

  }

}

// MARK: - CashDetailContentViewDelegate

extension CashFlowDetailContentView: CashDetailPeriodsViewDelegate {

  func didSelectPeriod(_ period: CashDetailPeriodType) {
    let newViewType: CashFlowDetailViewType = (period == .all) ? .table : .graphic
    if newViewType == viewType {
      delegate?.didChangePeriod(by: period)
    } else {
      viewType = newViewType
      delegate?.didChangePeriod(by: period)
    }
  }

}
