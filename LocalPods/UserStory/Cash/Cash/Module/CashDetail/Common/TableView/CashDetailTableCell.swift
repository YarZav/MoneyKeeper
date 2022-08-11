//
//  CashDetailTableCell.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import DesignSystem

final class CashDetailTableCell: UITableViewCell {

  // MARK: - Private property
  private var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .anthracite
    imageView.layer.cornerRadius = 16
    return imageView
  }()
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
    contentView.addSubview(iconImageView)
    contentView.addSubview(priceLabel)
    contentView.addSubview(categoryLabel)

    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
      iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

      priceLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
      priceLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
      priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

      categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      categoryLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
      categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
    ])
  }

}
