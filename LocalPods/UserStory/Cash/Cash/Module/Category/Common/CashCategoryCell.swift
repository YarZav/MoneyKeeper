//
//  CashCategoryCell.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import DesignSystem

final class CashFlowCategoryCell: UICollectionViewCell {
    
  // MARK: - Private property

  private let titleLabel = UILabel(font: UIFont.systemFont(ofSize: 14), textColor: .plainGray, textAlignment: .center)

  private lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .darkViolet
    return imageView
  }()

  // MARK: - Internal property

  var categoryModel: CashCategoryModel? {
    didSet {
      titleLabel.text = categoryModel?.title
      if let imageName = categoryModel?.imageName {
        let image = UIImage(named: imageName)
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

private extension CashFlowCategoryCell {

  func createUI(){
    contentView.cornerRadius(16, color: .darkViolet)
            
    contentView.addSubview(titleLabel)
    contentView.addSubview(iconImageView)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      iconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),

      titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
    ])
  }

}
