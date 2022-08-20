//
//  CashDetailPeriodsView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 18/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import DesignSystem

protocol CashDetailPeriodsViewDelegate: AnyObject {

  func didSelectPeriod(_ period: CashDetailPeriodType)

}

final class CashDetailPeriodsView: UIView {

  // MARK: - Private property

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .center
    stackView.spacing = DesignConstants.Margin.plain
    return stackView
  }()

  private var selectedPeriod: CashDetailPeriodType

  // MARK: - Internal property

  weak var delegate: CashDetailPeriodsViewDelegate?

  // MARK: - Init

  init(selectedPeriod: CashDetailPeriodType) {
    self.selectedPeriod = selectedPeriod
    super.init(frame: .zero)

    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("PeriodsView: use - init(selectedPeriod: PeriodType)")
  }

}

// MARK: - Prviate

private extension CashDetailPeriodsView {

  func createUI() {
    addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: DesignConstants.Margin.plain),
      stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -DesignConstants.Margin.plain),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
    
    let periods = CashDetailPeriodType.allCases
    periods.enumerated().forEach { (index, element) in
      let button = createButton(type: element)

      stackView.addArrangedSubview(button)

      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: stackView.topAnchor),
        button.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
      ])
    }
  }

  func createButton(type: CashDetailPeriodType) -> UIButton {
    let button = UIButton(type: .custom)
    button.tag = type.rawValue
    button.setTitle(type.title, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
    let titleColor: UIColor = selectedPeriod == type ? .white : .lightGray
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    return button
  }

}

// MARK: - Actions

private extension CashDetailPeriodsView {

  @objc
  func buttonAction(sender: UIButton) {
    stackView.subviews.forEach { ($0 as? UIButton)?.setTitleColor(.lightGray, for: .normal) }
    sender.setTitleColor(.white, for: .normal)

    guard let newPeriod = CashDetailPeriodType(rawValue: sender.tag) else { return }
    if newPeriod.rawValue == selectedPeriod.rawValue { return }

    selectedPeriod = newPeriod
    delegate?.didSelectPeriod(selectedPeriod)
  }

}
