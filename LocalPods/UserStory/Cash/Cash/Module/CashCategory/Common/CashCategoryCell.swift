//
//  CashCategoryCell.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import DesignSystem

final class CashCategoryCell: UICollectionViewCell {

  // MARK: - Constants

  private enum Constants {
    static let margin: CGFloat = 10
  }
    
  // MARK: - Private property

  private let titleLabel: UILabel = {
    let label = UILabel(font: UIFont.systemFont(ofSize: 14), textColor: .plainGray, textAlignment: .center)
    label.numberOfLines = 2
    return label
  }()

  private lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .darkViolet
    return imageView
  }()

  // MARK: - Internal property

  var cashCategoryType: CashCategoryType? {
    didSet {
        titleLabel.text = cashCategoryType?.rawValue.localized()
        if let imageName = cashCategoryType?.rawValue {
        let image = UIImage.named(imageName)
        iconImageView.image = image?.maskWithColor(color: .plainGray)
      }
    }
  }
  
  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

// MARK: - Private

private extension CashCategoryCell {

  func createUI(){
    contentView.cornerRadius(DesignConstants.Radius.plain, color: .darkViolet)

    contentView.addSubview(titleLabel)
    contentView.addSubview(iconImageView)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DesignConstants.Margin.plain),
      iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: DesignConstants.Margin.plain),
      iconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -DesignConstants.Margin.plain),

      titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: DesignConstants.Margin.small),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: DesignConstants.Margin.small),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -DesignConstants.Margin.small),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DesignConstants.Margin.plain),
    ])
  }

}
