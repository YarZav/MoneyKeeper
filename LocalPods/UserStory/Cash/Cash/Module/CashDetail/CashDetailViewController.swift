//
//  CashDetailViewController.swift
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
    static let titleInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
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

  private lazy var contentView: CashDetailContentView = {
    let view = CashDetailContentView(periodType: periodType)
    view.isHidden = true
    view.delegate = self
    return view
  }()

  // MARK: - Internal property

  var onMenu: (() -> Void)?

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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    presenter.prepareForDisplay(by: periodType, type: viewType)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if let titleView = navigationItem.titleView {
      navigationItem.titleView?.cornerRadius(titleView.bounds.size.height / 2, color: .darkRed)
    }
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
    contentView.reloadData(models: models)
  }

}

// MARK: - Private

private extension CashDetailViewController {

  func createUI() {
    createNavigationItem()

    view.backgroundColor = .darkViolet

    view.addSubview(noContentView)
    view.addSubview(contentView)

    noContentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      noContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      noContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

      contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  func createNavigationItem() {
    let labelView = LabelView(labelInsets: Constants.titleInsets)
    labelView.setText(viewType.rawValue.lowercased())
    labelView.setTextColor(.white)
    navigationItem.titleView = labelView

    let menuImage = UIImage.sliderHorizontal3
    let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(onMenuTapped))
    menuBarButtonItem.tintColor = .white
    navigationItem.rightBarButtonItem = menuBarButtonItem
  }

}

// MARK: - Action

private extension CashDetailViewController {

  @objc
  func onMenuTapped() {
    onMenu?()
  }

}

// MARK: - CashDetailContentViewDelegate

extension CashDetailViewController: CashDetailContentViewDelegate {

  func didChangePeriod(by period: CashDetailPeriodType) {
    periodType = period
    presenter.prepareForDisplay(by: periodType, type: viewType)
  }

}
