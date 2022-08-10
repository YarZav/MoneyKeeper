//
//  CashDetailTableCell.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

final class CashDetailTableCell: UITableViewCell {

  // MARK: - Private property
  private var iconImageView = UIImageView()
  private var priceLabel = UILabel(font: UIFont.systemFont(ofSize: 17), textColor: .white)
  private var categoryLabel = UILabel(font: UIFont.systemFont(ofSize: 15), textColor: .lightGray)

  // MARK: - Init

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    createUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

// MARK: - Internal

extension CashDetailTableCell {

  func display(imageName: String, price: String, category: String) {
    iconImageView.image = UIImage(named: imageName)
    priceLabel.text = price
    categoryLabel.text = category
  }

}

// MARK: - Private

private extension CashDetailTableCell {

  func createUI() {
    addSubview(iconImageView)
    addSubview(priceLabel)
    addSubview(categoryLabel)

    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      iconImageView.widthAnchor.constraint(equalToConstant: 20),
      iconImageView.heightAnchor.constraint(equalToConstant: 20),
      iconImageView.topAnchor.constraint(equalTo: topAnchor),
      iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

      priceLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
      priceLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor),
      priceLabel.rightAnchor.constraint(equalTo: rightAnchor),

      categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      categoryLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor),
      categoryLabel.rightAnchor.constraint(equalTo: rightAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

}
