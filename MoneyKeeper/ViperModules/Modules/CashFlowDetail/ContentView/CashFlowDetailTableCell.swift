//
//  CashFlowDetailTableCell.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailTableCell
class CashFlowDetailTableCell: BaseTableCell {

    //Properties
    private var iconView = UIImageView()
    private var priceLabel = UILabel()
    private var categoryLabel = UILabel()

    //Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowDetailTableCell {
    
    public func display(imageName: String, price: String, category: String) {
        self.iconView.image = UIImage(named: imageName)
        self.priceLabel.text = price
        self.categoryLabel.text = category
    }
}

// MARK: - Privates
extension CashFlowDetailTableCell {
    
    private func createUI() {
        self.priceLabel.textColor = .white
        self.priceLabel.font = UIFont.systemFont(ofSize: 17)
        
        self.categoryLabel.textColor = .lightGray
        self.categoryLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.addSubview(self.iconView)
        self.addSubview(self.priceLabel)
        self.addSubview(self.categoryLabel)
        
        self.iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
            $0.centerY.equalTo(self.priceLabel)
        }
        
        self.priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalTo(self.iconView.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
        
        self.categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.priceLabel.snp.bottom)
            $0.left.equalTo(self.iconView.snp.right).offset(8)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}
