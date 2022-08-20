//
//  CashViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Service
import DesignSystem

final class CashViewController: UIViewController, CashProtocol {

  // MARK: - Constants

  private enum Constants {
    static let maxPriceLength: Int = 7
    static let priceViewHeight: CGFloat = 120
  }

  // MARK: - CashProtocol

  var category: ((CashModel, (() -> Void)?) -> Void)?

  // MARK: - Private property

  private var presenter: CashPresenterProtocol

  private lazy var priceView: CashPriceView = {
    let view = CashPriceView()
    view.backgroundColor = .anthracite
    return view
  }()

  private lazy var numPadView: CashNumPadView = {
    let view = CashNumPadView(priceLengthLimit: Constants.maxPriceLength)
    view.delegate = self
    return view
  }()

  private lazy var acceptView: CashAcceptView = {
    let view = CashAcceptView(type: .outcome)
    view.backgroundColor = .anthracite
    view.delegate = self
    return view
  }()

  // MARK: - Init

  init(presenter: CashPresenterProtocol) {
    self.presenter = presenter

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
    presenter.viewDidApepar()
  }

}

// MARK: - Private

private extension CashViewController {

  func createUI() {
    view.backgroundColor = .anthracite

    view.addSubview(priceView)
    view.addSubview(numPadView)
    view.addSubview(acceptView)

    priceView.translatesAutoresizingMaskIntoConstraints = false
    numPadView.translatesAutoresizingMaskIntoConstraints = false
    acceptView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      priceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      priceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      priceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      priceView.heightAnchor.constraint(equalToConstant: Constants.priceViewHeight),

      numPadView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: numPadViewTopOffset),
      numPadView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      numPadView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

      acceptView.topAnchor.constraint(equalTo: numPadView.bottomAnchor, constant: numPadViewBottomOffset),
      acceptView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      acceptView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      acceptView.heightAnchor.constraint(equalToConstant: DesignConstants.Height.plain)
    ])
  }

  func ativateConstraint(_ isActivate: Bool) {
    acceptView.editing(isActivate)
    priceView.editing(isActivate)
  }

  func ativateAnimationConstraint(_ activate: Bool) {
    view.setNeedsLayout()
    UIView.animate(withDuration: DesignConstants.Time.plainDuration, animations: {
      self.ativateConstraint(activate)
      self.view.layoutIfNeeded()
    })
  }

}

// MARK: - CashViewProtocol

extension CashViewController: CashViewProtocol {

  func dropPrice() {
    numPadView.dropPrice()
    ativateConstraint(false)
  }
  
  func setTotalPrice(_ price: Decimal) {
    acceptView.setTotalPrice(price)
  }

  func presentCategory(with cashModel: CashModel) {
    category?(cashModel) { [weak self] in
      self?.dropPrice()
      self?.presenter.viewDidApepar()
    }
  }

}

// MARK: - CashNumPadDelegate

extension CashViewController: CashNumPadDelegate {

  func setCurrentPrice(_ price: String?) {
    priceView.priceText = price.isNilOrEmptyOrZero ? nil : price
    ativateAnimationConstraint(!price.isNilOrEmptyOrZero)
  }

}

// MARK: - CashAcceptDelegate

extension CashViewController: CashAcceptDelegate {

  func didTapNext() {
    presenter.didTapNext(with: priceView.priceText)
  }

}

// MARK: - NumPad offsets

private extension CashViewController {

  var numPadViewTopOffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1:
      return 0
    case .iPhone_6_7_8_SE2_SE3:
      return 20
    case .iPhone_6_7_8_Plus:
      return 30
    case .iPhone_X_Xs_11Pro_12Mini_13Mini:
      return 70
    case .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12ProMax_13ProMax:
      return 130
    case .iPhone_12_12Pro_13_13Pro:
      return 100
    }
  }

  var numPadViewBottomOffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1:
      return 10
    case .iPhone_6_7_8_SE2_SE3,
         .iPhone_6_7_8_Plus:
      return 30
    case .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax:
      return 40
    }
  }

}
