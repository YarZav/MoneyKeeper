//
//  CashFlowDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZBarChart
import Business
import DesignSystem

final class CashDetailViewController: UIViewController, CashDetailProtocol {

  // MARK: - Constants

  private enum Constants {
    static let emptyDataText = NSLocalizedString("EmptyData", comment: "The name of the empty data")
  }

  // MARK: - Private property

  private let presenter: CashDetailPresenterProtocol
  private var periodType: CashDetailPeriodType = .week
  private var viewType: CashType = .outcome

  private let noContentView = LabelView()
  private var contentView: CashFlowDetailContentView?

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
    if let contentView = contentView, view.subviews.contains(contentView) {
      contentView.removeFromSuperview()
    }

    if !view.subviews.contains(noContentView) {
      view.addSubview(noContentView)
      noContentView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        noContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        noContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      ])
    }
    noContentView.setText(Constants.emptyDataText)
  }

  func showContentView() {
    if view.subviews.contains(noContentView) {
      noContentView.removeFromSuperview()
    }
    
    if contentView == nil {
      contentView = CashFlowDetailContentView(periodType: periodType)
      contentView?.delegate = self
    }
    
    if let contentView = contentView, !view.subviews.contains(contentView) {
      view.addSubview(contentView)
      contentView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      ])
    }
  }

  func displayGraphic(models: [CashModel], barModels: [YZBarViewModel]) {
    contentView?.displayGraphic(barModels: barModels, models: models, completion: {
      //FIXME: USe it
    })
  }

  func insertTable(models: [CashModel]) {
    contentView?.insertTable(models: models, completion: {
        //FIXME: Use it
    })
  }

}

// MARK: - Private

private extension CashDetailViewController {

  func createUI() {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkRed]
    navigationItem.title = viewType.title
    view.backgroundColor = .darkViolet
  }

}

// MARK: - CashDetailContentViewDelegate

extension CashDetailViewController: CashDetailContentViewDelegate {

  func didChangePeriod(by period: CashDetailPeriodType) {
    periodType = period
    presenter.prepareForDisplay(by: periodType, type: viewType)
  }

}
