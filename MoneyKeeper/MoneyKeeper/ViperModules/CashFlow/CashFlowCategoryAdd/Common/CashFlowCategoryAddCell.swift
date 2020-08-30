//
//  CashFlowCategoryAddCell.swift
//  MoneyKeeper
//
//  Created by admin on 06/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowCategoryAddCell
class CashFlowCategoryAddCell: UICollectionViewCell {
    
    //Properties
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
extension CashFlowCategoryAddCell {
    
    private func createUI(){
        self.contentView.cornerRadius(10, color: .darkViolet)
        
        self.iconImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
}

// MARK: - Publics
extension CashFlowCategoryAddCell {
    
    public func display(_ imageName: String) {
        self.iconImageView.image = UIImage(named: imageName)
    }
}
