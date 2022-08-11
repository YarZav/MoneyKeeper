//
//  CashAcceptView.swift
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

protocol CashAcceptDelegate: AnyObject {

  func didTapNext()

}

final class CashAcceptView: UIView {

  // MARK: - Constants

  enum Constants {
    static let nextButtonWidth: CGFloat = 210
    // TODO: - Вынести
    static let buttonHeight: CGFloat = 44
    static let priceLeftOffset: CGFloat = -26
    static let totalRightOffset: CGFloat = -26
    static let totalLeftOffset: CGFloat = 40
    static let nextEnabledRightOffset: CGFloat = 32
    static let nextText = "CashFlowNextKey".localized()
  }

  // MARK: - Pirvte property

  private let color = UIColor.darkViolet.withAlphaComponent(0.5)
  private var nextButtonRightConstraint: NSLayoutConstraint!

  private lazy var currentPriceView: UIView = {
      let view = UIView()
      view.cornerRadius(20, color: color)
      view.backgroundColor = .darkRed
      return view
  }()

  private lazy var totalPriceLabel: UILabel = {
      let label = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white, textAlignment: .right)
      label.text = "0"
      return label
  }()

  private lazy var nextButton: YZRoundButton = {
    let button = YZRoundButton(backgroundColor: color, radius: 20, borderColor: color, borderWidth: 1)
    button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    button.setTitle(Constants.nextText, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 26.0, bottom: 0.0, right: 40.0)
    return button
  }()

  // MARK: - Internal property

  weak var delegate: CashAcceptDelegate?

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

extension CashAcceptView {

  func setTotalPrice(_ price: String?) {
    layoutIfNeeded()
    UIView.animate(withDuration: 0.15) {
      self.totalPriceLabel.text = price
      self.layoutIfNeeded()
    }
  }

}

// MARK: - Private
private extension CashAcceptView {

  func createUI() {
    addSubview(currentPriceView)
    currentPriceView.addSubview(totalPriceLabel)
    addSubview(nextButton)

    currentPriceView.translatesAutoresizingMaskIntoConstraints = false
    totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false

    nextButtonRightConstraint = nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.nextButtonWidth)

    NSLayoutConstraint.activate([
      nextButton.topAnchor.constraint(equalTo: topAnchor),
      nextButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      nextButtonRightConstraint,
      nextButton.widthAnchor.constraint(equalToConstant: Constants.nextButtonWidth),

      currentPriceView.topAnchor.constraint(equalTo: topAnchor),
      currentPriceView.bottomAnchor.constraint(equalTo: bottomAnchor),
      currentPriceView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.priceLeftOffset),

      totalPriceLabel.topAnchor.constraint(equalTo: currentPriceView.topAnchor),
      totalPriceLabel.bottomAnchor.constraint(equalTo: currentPriceView.bottomAnchor),
      totalPriceLabel.rightAnchor.constraint(equalTo: currentPriceView.rightAnchor, constant: Constants.totalRightOffset),
      totalPriceLabel.leftAnchor.constraint(equalTo: currentPriceView.leftAnchor, constant: Constants.totalLeftOffset)
    ])
  }

}

// MARK: - Actions

private extension CashAcceptView {

  @objc
  func nextAction() {
    delegate?.didTapNext()
  }

}

// MARK: - Internal

extension CashAcceptView {

  func editing(_ isEdiging: Bool) {
    layoutIfNeeded()
    UIView.animate(withDuration: 0.25) {
      self.nextButtonRightConstraint.constant = isEdiging ? Constants.nextEnabledRightOffset : Constants.nextButtonWidth
      self.layoutIfNeeded()
    }
  }

}
