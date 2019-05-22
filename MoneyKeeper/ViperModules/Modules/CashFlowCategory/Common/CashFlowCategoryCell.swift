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
    func longPress(indexPath: IndexPath)
}

// MARK: - CashFlowCategoryCell
class CashFlowCategoryCell: UICollectionViewCell {
    
    // Properties
    public weak var delegate: CashFlowCategoryCellDelegate?
    private var indexPath: IndexPath!
    private var titleLabel: UILabel!
    private var iconImageView: UIImageView!
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates
extension CashFlowCategoryCell {
    
    private func createUI(){
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.darkViolet
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(sender:)))
        self.contentView.addGestureRecognizer(longPressRecognizer)
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.textAlignment = .center
        
        self.iconImageView = UIImageView()
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.iconImageView)

        self.iconImageView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.iconImageView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        self.delegate?.longPress(indexPath: self.indexPath)
    }
}

// MARK: - Publics
extension CashFlowCategoryCell {
    
    public func display(title: String?, icon: String?, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.titleLabel.text = title
        if let icon = icon {
            self.iconImageView.image = UIImage(named: icon)
        }
    }
}
