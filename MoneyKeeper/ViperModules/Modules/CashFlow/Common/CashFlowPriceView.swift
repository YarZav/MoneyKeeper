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
    public var priceLabel: UILabel!
    public var titleConstraint: Constraint!
    
    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
}

// MARK: - Privates
extension CashFlowPriceView {
    
    private func createUI() {
        let darkGrayCircle = self.createCircle(radius: 248, color: UIColor.darkViolet)
        let grayCircle = self.createCircle(radius: 175, color: UIColor.white.withAlphaComponent(0.4))
        let whiteCircle = self.createCircle(radius: 178, color: .white)
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 36)
        titleLabel.text = "COIN\nWALLET"
        
        self.priceLabel = UILabel()
        self.priceLabel.font = UIFont.systemFont(ofSize: 36)
        self.priceLabel.textAlignment = .right
        
        self.addSubview(darkGrayCircle)
        darkGrayCircle.addSubview(grayCircle)
        self.addSubview(whiteCircle)
        self.addSubview(titleLabel)
        self.addSubview(self.priceLabel)
        
        darkGrayCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-325)
            $0.left.equalToSuperview().offset(-91)
            $0.width.equalTo(496)
            $0.height.equalTo(496)
        }
        
        grayCircle.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(70)
            $0.centerX.equalToSuperview().offset(-10)
            $0.width.equalTo(350)
            $0.height.equalTo(350)
        }
        
        whiteCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-214)
            $0.left.equalToSuperview().offset(-71)
            $0.width.equalTo(356)
            $0.height.equalTo(356)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(218)
            $0.centerX.equalTo(grayCircle).priority(900)
            $0.centerY.equalTo(grayCircle)
            self.titleConstraint = $0.right.equalTo(self.snp.left).offset(-218).priority(999).constraint
        }
        
        self.priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.equalTo(self.snp.left).offset(16)
            $0.right.equalTo(whiteCircle.snp.right).offset(-40)
        }
    }
    
    private func createCircle(radius: CGFloat, color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        return view
    }
}
