//
//  AddCashPriceView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import DesignSystem

// MARK: - AddCashPriceView

final class AddCashPriceView: UIView {

  // MARK: - Constants

  private enum Constants {
    static let titleText = "COIN\nWALLET"
    static let titleWidth: CGFloat = 218
    static let threeCircleHeight: CGFloat = 191
    static let priceRightOffset: CGFloat = -40
  }
  
  // MARK: - Private property

  private let threeCircleView = ThreeCircleView(first: .darkViolet, second: .plainGray, third: .white)
  private let priceLabel = UILabel(font: UIFont.systemFont(ofSize: 36), textAlignment: .right)

  private lazy var titleLabel: UILabel = {
    let label = UILabel(font: UIFont.systemFont(ofSize: 36))
    label.numberOfLines = 2
    label.text = "COIN\nWALLET"
    return label
  }()

  // MARK: - Internal property

  var priceText: String? {
    get { priceLabel.text }
    set { priceLabel.text = newValue }
  }

  // MARK: - Init

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init() {
    super.init(frame: .zero)

    createUI()
  }

}

// MARK: - Private

private extension AddCashPriceView {

  func createUI() {
    addSubview(threeCircleView)
    addSubview(titleLabel)
    addSubview(priceLabel)

    threeCircleView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      threeCircleView.leftAnchor.constraint(equalTo: leftAnchor),
      threeCircleView.rightAnchor.constraint(equalTo: rightAnchor),
      threeCircleView.heightAnchor.constraint(equalToConstant: Constants.threeCircleHeight),

      titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleWidth),
      titleLabel.centerXAnchor.constraint(equalTo: threeCircleView.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: threeCircleView.centerYAnchor),

      priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
      priceLabel.leftAnchor.constraint(equalTo: leftAnchor),
      priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.priceRightOffset),
    ])
  }

}

// MARK: - Internal

extension AddCashPriceView {

  func editing(_ isEditing: Bool) {
    UIView.animate(withDuration: 0.25) {
      self.titleLabel.alpha = isEditing ? 0 : 1
    }
  }

}
