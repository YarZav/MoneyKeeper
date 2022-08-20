//
//  CashFlowDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import YZBarChart
import DesignSystem

final class CashDetailViewController: UIViewController, CashDetailProtocol {

  // MARK: - Constants

  private enum Constants {
      static let emptyDataText = "EmptyDataKey".localized()
  }

  // MARK: - Private property

  private let presenter: CashDetailPresenterProtocol
  private var periodType: CashDetailPeriodType = .week
  private var viewType: CashType = .outcome

  private let noContentView: LabelView = {
    let view = LabelView()
    view.isHidden = true
    return view
  }()

  private lazy var contentView: CashFlowDetailContentView = {
    let view = CashFlowDetailContentView(periodType: periodType)
    view.isHidden = true
    view.delegate = self
    return view
  }()

  // MARK: - Init

  init(presenter: CashDetailPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
    presenter.viewDidLoad(by: periodType, type: viewType)
  }

}

// MARK: - CashDetailViewProtocol

extension CashDetailViewController: CashDetailViewProtocol {

  func showNoContentView() {
    contentView.isHidden = true
    noContentView.isHidden = false
    noContentView.setText(Constants.emptyDataText)
  }

  func showContentView(models: [CashModel], barModels: [YZBarViewModel]) {
    contentView.isHidden = false
    noContentView.isHidden = true

    contentView.displayGraphic(barModels: barModels, models: models)
    contentView.insertTable(models: models)
  }

}

// MARK: - Private

private extension CashDetailViewController {

  func createUI() {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkRed]
    navigationItem.title = viewType.title
    view.backgroundColor = .darkViolet

    view.addSubview(noContentView)
    view.addSubview(contentView)

    noContentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      noContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      noContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

      contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

}

// MARK: - CashDetailContentViewDelegate

extension CashDetailViewController: CashDetailContentViewDelegate {

  func didChangePeriod(by period: CashDetailPeriodType) {
    periodType = period
    presenter.prepareForDisplay(by: periodType, type: viewType)
  }

}
