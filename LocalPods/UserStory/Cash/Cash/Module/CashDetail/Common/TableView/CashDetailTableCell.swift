//
//  CashDetailTableCell.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import DesignSystem

final class CashDetailTableCell: UITableViewCell {

  // MARK: - Private property

  private lazy var containerImageView: UIView = {
    let view = UIView()
    view.backgroundColor = .anthracite
    view.layer.cornerRadius = DesignConstants.Radius.plain
    return view
  }()

  private lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
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
    contentView.addSubview(containerImageView)
    containerImageView.addSubview(iconImageView)
    contentView.addSubview(priceLabel)
    contentView.addSubview(categoryLabel)

    containerImageView.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      containerImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: DesignConstants.Margin.plain),
      containerImageView.widthAnchor.constraint(equalTo: containerImageView.heightAnchor),
      containerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DesignConstants.Margin.plain),
      containerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DesignConstants.Margin.plain),

      iconImageView.leftAnchor.constraint(equalTo: containerImageView.leftAnchor, constant: DesignConstants.Margin.small),
      iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
      iconImageView.topAnchor.constraint(equalTo: containerImageView.topAnchor, constant: DesignConstants.Margin.small),
      iconImageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -DesignConstants.Margin.small),

      priceLabel.topAnchor.constraint(equalTo: containerImageView.topAnchor),
      priceLabel.leftAnchor.constraint(equalTo: containerImageView.rightAnchor, constant: DesignConstants.Margin.plain),
      priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

      categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      categoryLabel.leftAnchor.constraint(equalTo: containerImageView.rightAnchor, constant: DesignConstants.Margin.plain),
      categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor),
    ])
  }

}
