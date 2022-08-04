//
//  AddCashAcceptView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZNumPad
import Business
import Extension
import DesignSystem

private struct AddCashAcceptStruct {

  static var totalPriceWidth: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE?:
        return 200
      case .iPhone_6_7_8?:
        return 276
      case .iPhone_6_7_8_Plus?:
        return 276
      case .iPhone_X_Xs_11Pro?:
        return 276
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 276
      default:
        return 0
      }
    }
  }

}

protocol AddCashAcceptDelegate: AnyObject {

  func presentCashCategory()

}

final class AddCashAcceptView: UIView {

  // MARK: - Constants

  enum Constants {
    static let nextButtonWidth: CGFloat = 210
    // TODO: - Вынести
    static let buttonHeight: CGFloat = 44
    static let priceLeftOffset: CGFloat = -26
    static let totalRightOffset: CGFloat = -26
    static let totalLeftOffset: CGFloat = 40
    static let nextEnabledRightOffset: CGFloat = 32
  }

  // MARK: - Pirvte property

  private let color = UIColor.darkViolet.withAlphaComponent(0.5)
  private var nextButtonRightConstraint: NSLayoutConstraint!

  private lazy var priceView: UIView = {
      let view = UIView()
      view.cornerRadius(20, color: color)
      view.backgroundColor = .darkRed
      return view
  }()

  private lazy var totalLabel: UILabel = {
      let label = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white, textAlignment: .right)
      label.text = "0"
      return label
  }()

  private lazy var nextButton: YZRoundButton = {
      let button = YZRoundButton(backgroundColor: color, radius: 20, borderColor: color, borderWidth: 1)
      button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
      button.setTitle("CashFlowNext", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 26.0, bottom: 0.0, right: 40.0)
      return button
  }()

  // MARK: - Internal property

  weak var delegate: AddCashAcceptDelegate?

  // MARK: - Init

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init(type: CashType) {
    super.init(frame: .zero)

    createUI()
  }

}

// MARK: - Internal

extension AddCashAcceptView {

  func displayTotal(_ total: String?, type: CashType) {
    layoutIfNeeded()
    UIView.animate(withDuration: 0.15) {
      self.totalLabel.text = total
      self.layoutIfNeeded()
    }
  }

}

// MARK: - Private
private extension AddCashAcceptView {

  func createUI() {
    addSubview(priceView)
    priceView.addSubview(totalLabel)
    addSubview(nextButton)

    priceView.translatesAutoresizingMaskIntoConstraints = false
    totalLabel.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false

    nextButtonRightConstraint = nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.nextEnabledRightOffset)

    NSLayoutConstraint.activate([
      nextButton.topAnchor.constraint(equalTo: topAnchor),
      nextButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      nextButtonRightConstraint,
      nextButton.widthAnchor.constraint(equalToConstant: Constants.nextButtonWidth),

      priceView.topAnchor.constraint(equalTo: topAnchor),
      priceView.bottomAnchor.constraint(equalTo: bottomAnchor),
      priceView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.priceLeftOffset),

      totalLabel.topAnchor.constraint(equalTo: priceView.topAnchor),
      totalLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
      totalLabel.rightAnchor.constraint(equalTo: priceView.rightAnchor, constant: Constants.totalRightOffset),
      totalLabel.leftAnchor.constraint(equalTo: priceView.leftAnchor, constant: Constants.totalLeftOffset)
    ])
  }

}

// MARK: - Actions

private extension AddCashAcceptView {

  @objc
  func nextAction() {
    delegate?.presentCashCategory()
  }

}

// MARK: - Internal

extension AddCashAcceptView {

  func editing(_ isEdiging: Bool) {
    layoutIfNeeded()
    UIView.animate(withDuration: 0.25) {
      self.nextButtonRightConstraint.constant = isEdiging ? Constants.nextEnabledRightOffset : Constants.nextButtonWidth
      self.layoutIfNeeded()
    }
  }

}
