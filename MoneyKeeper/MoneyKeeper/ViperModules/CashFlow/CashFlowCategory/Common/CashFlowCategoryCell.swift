//
//  CashFlowCategoryCell.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowCategoryCellDelegate
protocol CashFlowCategoryCellDelegate: class {
    func longPress(_ cell: CashFlowCategoryCell)
}

// MARK: - CashFlowCategoryCell
class CashFlowCategoryCell: UICollectionViewCell {
    
    // Properties
    public weak var delegate: CashFlowCategoryCellDelegate?
    private var titleLabel = UILabel(font: UIFont.systemFont(ofSize: 14), textColor: .white, textAlignment: .center)
    private var iconImageView = UIImageView()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Privates
extension CashFlowCategoryCell {
    
    private func createUI(){
        self.contentView.cornerRadius(16, color: .darkViolet)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        self.contentView.addGestureRecognizer(longPressRecognizer)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.iconImageView)

        self.iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.iconImageView.snp.bottom).offset(8)
            $0.right.bottom.equalToSuperview().offset(-8)
            $0.left.equalToSuperview().offset(8)
        }
    }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer) {
        self.delegate?.longPress(self)
    }
}

// MARK: - Publics
extension CashFlowCategoryCell {
    
    public func display(title: String?, icon: String?) {
        self.titleLabel.text = title?.localized()
        if let icon = icon {
            self.iconImageView.image = UIImage(named: icon)
        }
    }
}
