//
//  CashFlowDetailCell.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 06/04/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailCell
class CashFlowDetailCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    private var priceLabel = UILabel()
    private var categoryLabel = UILabel()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowDetailCell {
    
    public func display(imageName: String, price: String, category: String) {
        self.imageView.image = UIImage(named: imageName)
        self.priceLabel.text = price
        self.categoryLabel.text = category        
    }
}

// MARK: - Privates
extension CashFlowDetailCell {
    
    private func createUI() {
        self.priceLabel.textAlignment = .center
        self.priceLabel.textColor = .white
        self.priceLabel.font = UIFont.systemFont(ofSize: 17)
        
        self.categoryLabel.textAlignment = .center
        self.categoryLabel.textColor = .lightGray
        self.categoryLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.addSubview(self.imageView)
        self.addSubview(self.priceLabel)
        self.addSubview(self.categoryLabel)
        
        self.imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
            $0.centerY.equalTo(self.priceLabel)
        }
        
        self.priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(self.imageView.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
        
        self.categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.priceLabel.snp.bottom)
            $0.left.equalTo(self.imageView.snp.right).offset(8)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
