//
//  CashAcceptView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import YZNumPad
import DesignSystem

protocol CashAcceptDelegate: AnyObject {

  func didTapNext()

}

final class CashAcceptView: UIView {

  // MARK: - Constants

  enum Constants {
    static let nextButtonWidth: CGFloat = 210
    static let priceLeftOffset: CGFloat = -26
    static let totalRightOffset: CGFloat = -26
    static let totalLeftOffset: CGFloat = 40
    static let nextEnabledRightOffset: CGFloat = 32
    static let cornerRadius: CGFloat = 20
    static let nextButtonInsets: UIEdgeInsets = .init(top: 0.0, left: 26.0, bottom: 0.0, right: 40.0)
    static let nextText = "CashNextKey".localized()
  }

  // MARK: - Pirvte property

  private let color = UIColor.darkViolet.withAlphaComponent(0.5)
  private lazy var nextButtonRightConstraint: NSLayoutConstraint = {
    nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.nextButtonWidth)
  }()

  private lazy var currentPriceView: UIView = {
    let view = UIView()
    view.cornerRadius(Constants.cornerRadius, color: color)
    view.backgroundColor = .darkRed
    return view
  }()

  private lazy var totalPriceLabel: UILabel = {
      let label = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white, textAlignment: .right)
      label.text = "0"
      return label
  }()

  private lazy var nextButton: YZRoundButton = {
    let button = YZRoundButton(backgroundColor: color, radius: Constants.cornerRadius, borderColor: color, borderWidth: 1)
    button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    button.setTitle(Constants.nextText, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleEdgeInsets = Constants.nextButtonInsets
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

  func setTotalPrice(_ price: Decimal) {
    layoutIfNeeded()
    UIView.animate(withDuration: DesignConstants.Time.plainDuration) {
      self.totalPriceLabel.text = price.toString(.currency)
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
    UIView.animate(withDuration: DesignConstants.Time.plainDuration) {
      self.nextButtonRightConstraint.constant = isEdiging ? Constants.nextEnabledRightOffset : Constants.nextButtonWidth
      self.layoutIfNeeded()
    }
  }

}
