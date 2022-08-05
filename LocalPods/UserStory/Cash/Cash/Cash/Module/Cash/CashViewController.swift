//
//  CashViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Business

private struct Constant {

  static var numPadViewTopOffset: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE1?:
        return 43
      case .iPhone_6_7_8_SE2_SE3?:
        return 80
      case .iPhone_6_7_8_Plus?:
        return 80
      case .iPhone_X_Xs_11Pro_12Mini_13Mini?:
        return 100
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 130
      default:
        return 0
      }
    }
  }
  
  static var numPadViewBottomOffset: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE1?:
        return 10
      case .iPhone_6_7_8_SE2_SE3?:
        return 30
      case .iPhone_6_7_8_Plus?:
        return 30
      case .iPhone_X_Xs_11Pro_12Mini_13Mini?:
        return 40
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 40
      default:
        return 0
      }
    }
  }

}

// MARK: - CashViewController
final class CashViewController: UIViewController {

  // MARK: - Private property

  private var presenter: CashPresenter
  private var type: CashType = .outcome

  private var priceView = CashPriceView()
  private var numPadView = CashNumPadView(priceLengthLimit: 7)
  private var acceptView: CashAcceptView!

  init(presenter: CashPresenter) {
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
    presenter.viewDidApepar(type: type)
  }

}

// MARK: - CashView

extension CashViewController: CashView {

  func dropPrice() {
    numPadView.dropPrice()
  }
  
  func setTotalPrice(_ total: String?) {
    acceptView.displayTotal(total, type: type)
  }
}

// MARK: - Private

private extension CashViewController {

  func createUI() {
    let backgroundColor = UIColor.anthracite
    view.backgroundColor = backgroundColor
    
    priceView.backgroundColor = backgroundColor
    numPadView.delegate = self
    
    acceptView = CashAcceptView(type: type)
    acceptView.backgroundColor = backgroundColor
    acceptView.delegate = self
    
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
      priceView.heightAnchor.constraint(equalToConstant: 150),

      numPadView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: Constant.numPadViewTopOffset),
      numPadView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      numPadView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

      acceptView.topAnchor.constraint(equalTo: numPadView.bottomAnchor, constant: Constant.numPadViewBottomOffset),
      acceptView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      acceptView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      acceptView.heightAnchor.constraint(equalToConstant: 44)
    ])

    ativateConstraint(false)
  }

  func ativateConstraint(_ isActivate: Bool) {
    if isActivate {
      acceptView.editing(true)
      priceView.editing(true)
    } else {
      acceptView.editing(false)
      priceView.editing(false)
    }
  }

  func ativateAnimationConstraint(_ activate: Bool) {
    view.setNeedsLayout()
    UIView.animate(withDuration: 0.15, animations: {
      self.ativateConstraint(activate)
      self.view.layoutIfNeeded()
    })
  }

}

// MARK: - CashNumPadDelegate

extension CashViewController: CashNumPadDelegate {

  func setPrice(_ price: String?) {
    if let price = price, !(price.isEmpty || price == "0") {
        priceView.priceText = price
        ativateAnimationConstraint(true)
    } else {
        priceView.priceText = nil
        ativateAnimationConstraint(false)
    }
  }

}

// MARK: - CashAcceptDelegate

extension CashViewController: CashAcceptDelegate {

  func presentCategory() {
    guard let priceText = priceView.priceText, !priceText.isEmpty else { return }
    presenter.presentCategory(price: priceText, type: type)
  }

}
