//
//  CashFlowPriceView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - CashFlowPriceView
class CashFlowPriceView: UIView {
    
    //Properties
    public var priceLabel = UILabel(font: UIFont.systemFont(ofSize: 36), textAlignment: .right)
    public var titleConstraint: Constraint!
    
    //Init
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
}

// MARK: - Privates
extension CashFlowPriceView {
    
    private func createUI() {
        let threeCircleView = ThreeCircleView(first: UIColor.darkViolet, second: UIColor.white.withAlphaComponent(0.4), third: .white)
        self.addSubview(threeCircleView)
        threeCircleView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(191)
        }
        
        let titleLabel = UILabel(font: UIFont.systemFont(ofSize: 36))
        titleLabel.numberOfLines = 2
        titleLabel.text = "COIN\nWALLET"
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(218)
            $0.centerX.equalTo(threeCircleView).priority(900)
            $0.centerY.equalTo(threeCircleView)
            self.titleConstraint = $0.right.equalTo(self.snp.left).offset(-218).priority(999).constraint
        }
        
        self.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.equalTo(self.snp.left).offset(16)
            $0.right.equalTo(threeCircleView.snp.right).offset(-40)
        }
    }
}
