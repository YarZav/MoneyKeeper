//
//  AddCashViewController.swift
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
      case .iPhone_5S_SE?:
        return 43
      case .iPhone_6_7_8?:
        return 80
      case .iPhone_6_7_8_Plus?:
        return 80
      case .iPhone_X_Xs_11Pro?:
        return 100
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 180
      default:
        return 0
      }
    }
  }
  
  static var numPadViewBottomOffset: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE?:
        return 10
      case .iPhone_6_7_8?:
        return 34
      case .iPhone_6_7_8_Plus?:
        return 34
      case .iPhone_X_Xs_11Pro?:
        return 50
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 50
      default:
        return 0
      }
    }
  }
}

// MARK: - CashViewController
final class AddCashViewController: UIViewController {
  
  //Properties
  public var presenter: AddCashPresenter!
  public var type: CashType = .outcome
  
  private var priceView = AddCashPriceView()
  private var numPadView = AddCashNumPadView(priceLengthLimit: 7)
  private var acceptView: AddCashAcceptView!
  
  //Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    createUI()
    presenter.viewDidApepar(type: type)
  }
}

// MARK: - AddCashView
extension AddCashViewController: AddCashView {
    
  func updateStringLocalization() {
    acceptView.updateLocalizedString()
  }
  
  func dropPrice() {
    numPadView.dropPrice()
  }
  
  func setTotalPrice(_ total: String?) {
    acceptView.displayTotal(total, type: type)
  }
}

// MARK: - Privates
extension AddCashViewController {
    
  private func createUI() {
    let backgroundColor = UIColor.anthracite
    view.backgroundColor = backgroundColor
    
    priceView.backgroundColor = backgroundColor
    numPadView.delegate = self
    
    acceptView = AddCashAcceptView(color: UIColor.darkViolet.withAlphaComponent(0.5), type: type)
    acceptView.backgroundColor = backgroundColor
    acceptView.delegate = self
    
    view.addSubview(priceView)
    view.addSubview(numPadView)
    view.addSubview(acceptView)
    
//    priceView.snp.makeConstraints {
//      $0.left.right.top.equalToSuperview()
//      $0.height.equalTo(150)
//    }
//
//    numPadView.snp.makeConstraints {
//      $0.top.equalTo(priceView.snp.bottom).offset(Constant.numPadViewTopOffset)
//      $0.left.right.equalToSuperview()
//    }
//
//    acceptView.snp.makeConstraints {
//      $0.top.equalTo(numPadView.snp.bottom).offset(Constant.numPadViewBottomOffset)
//      $0.left.right.equalToSuperview()
//      $0.height.equalTo(44)
//    }
    
    ativateConstraint(false)
  }
  
  private func ativateConstraint(_ isActivate: Bool) {
//    if isActivate {
//      acceptView.buttonConstraint.activate()
//      priceView.titleConstraint.activate()
//    } else {
//      acceptView.buttonConstraint.deactivate()
//      priceView.titleConstraint.deactivate()
//    }
  }
  
  private func ativateAnimationConstraint(_ activate: Bool) {
    view.setNeedsLayout()
    UIView.animate(withDuration: 0.15, animations: {
        self.ativateConstraint(activate)
        self.view.layoutIfNeeded()
    })
  }
}

// MARK: - AddCashNumPadDelegate
extension AddCashViewController: AddCashNumPadDelegate {
    
  func price(_ price: String?) {
    if let price = price, !(price.isEmpty || price == "0") {
        priceView.priceLabel.text = price
        ativateAnimationConstraint(true)
    } else {
        priceView.priceLabel.text = nil
        ativateAnimationConstraint(false)
    }
  }
}

// MARK: - AddCashExtraDelegate
extension AddCashViewController: AddCashAcceptDelegate {
    
  func didChangeCashType() {
    switch type {
    case .outcome:
      type = .income
    case .income:
      type = .outcome
    }
    
    presenter.viewDidApepar(type: type)
  }
  
  func presentCashCategory() {
    guard let price = priceView.priceLabel.text, !price.isEmpty else { return }
    presenter.presentCashCategory(price: price, type: type)
  }
}
