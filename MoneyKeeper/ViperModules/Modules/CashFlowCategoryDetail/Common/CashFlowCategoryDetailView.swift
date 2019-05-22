//
//  CashFlowCategoryDetailView.swift
//  MoneyKeeper
//
//  Created by admin on 04.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - CashFlowCategoryDetailView
class CashFlowCategoryDetailView: UIView {
    
    // Properties
    private var model: CashFlowModel!
    private var transition: Bool = false
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var container: UIView!
    private var categoryLabel: MarginLabel!
    private var priceLabel: MarginLabel!
    
    private var blurLightHeightConstraint: Constraint!
    
    private var leftViewConstraint: Constraint!
    private var rightPriorityViewConstraint: Constraint!
    private var widthPriorityViewConstraint: Constraint!
    private var heightPriorityViewConstraint: Constraint!
    
    private var widthPriorityImageConstraint: Constraint!
    private var heightPriorityImageConstraint: Constraint!
    private var centerYPriorityImageConstraint: Constraint!
    
    private var titleLabelBottomConstraint: Constraint!
    
    private var containerLeftConstraint: Constraint!
    private var containerRightConstraint: Constraint!

    // Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    init(model: CashFlowModel, transition: Bool) {
        super.init(frame: .zero)
        self.model = model
        self.transition = transition
        self.createUI()
        self.displayModel()
    }
}

// MARK: - Publics
extension CashFlowCategoryDetailView {
    
    public func presentAnimate() {
        self.blurLightHeightConstraint.deactivate()
        
        self.rightPriorityViewConstraint.activate()
        self.widthPriorityViewConstraint.activate()
        self.heightPriorityViewConstraint.activate()
        
        self.titleLabelBottomConstraint.deactivate()
        self.titleLabel.alpha = 0
        
        self.widthPriorityImageConstraint.activate()
        self.heightPriorityImageConstraint.activate()
        self.centerYPriorityImageConstraint.activate()
        
        self.containerLeftConstraint.deactivate()
        self.containerRightConstraint.deactivate()
        self.container.alpha = 1
    }
    
    public func dismissAnimate() {
        self.blurLightHeightConstraint.activate()

        self.rightPriorityViewConstraint.deactivate()
        self.widthPriorityViewConstraint.deactivate()
        self.heightPriorityViewConstraint.deactivate()
        
        self.titleLabelBottomConstraint.activate()
        self.titleLabel.alpha = 1
        
        self.widthPriorityImageConstraint.deactivate()
        self.heightPriorityImageConstraint.deactivate()
        self.centerYPriorityImageConstraint.deactivate()
        
        self.containerLeftConstraint.activate()
        self.containerRightConstraint.activate()
        self.container.alpha = 0
    }
}

// MARK: - Privates
extension CashFlowCategoryDetailView {
    
    private func createUI() {
        self.backgroundColor = .clear
        
        let blurLightEffect = UIBlurEffect(style: .light)
        let blurLightView = UIVisualEffectView(effect: blurLightEffect)
        blurLightView.layer.cornerRadius = 16.0
        blurLightView.layer.masksToBounds = true
        
        let view = UIView()
        view.backgroundColor = UIColor.darkViolet
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = true
        
        self.iconImageView = UIImageView()
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.textAlignment = .center
        
        self.container = UIView()
        self.container.backgroundColor = .clear
        
        self.categoryLabel = MarginLabel()
        self.categoryLabel.font = UIFont.systemFont(ofSize: 17)
        
        self.priceLabel = MarginLabel()
        self.priceLabel.font = UIFont.systemFont(ofSize: 17)
        
        self.addSubview(blurLightView)
        self.addSubview(view)
        view.addSubview(self.iconImageView)
        view.addSubview(self.titleLabel)
        self.addSubview(self.container)
        self.container.addSubview(self.categoryLabel)
        self.container.addSubview(self.priceLabel)
        
        blurLightView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(CashFlowCategoryStruct.itemSize.height + 24).priority(900)
            self.blurLightHeightConstraint = $0.height.equalTo(CashFlowCategoryStruct.itemSize.height).priority(999).constraint
        }
        
        view.snp.makeConstraints {
            $0.right.equalToSuperview().offset(0).priority(900)
            $0.width.equalTo(CashFlowCategoryStruct.itemSize.width).priority(900)
            $0.height.equalTo(CashFlowCategoryStruct.itemSize.height).priority(900)
            $0.centerY.equalToSuperview()

            self.rightPriorityViewConstraint = $0.right.equalToSuperview().offset(-8).priority(999).constraint
            self.widthPriorityViewConstraint = $0.width.equalTo(115).priority(999).constraint
            self.heightPriorityViewConstraint = $0.height.equalTo(100).priority(999).constraint
        }

        self.iconImageView.snp.makeConstraints {
            $0.width.equalTo(40).priority(900)
            $0.height.equalTo(40).priority(900)
            $0.centerX.equalToSuperview()

            self.widthPriorityImageConstraint = $0.width.equalToSuperview().multipliedBy(0.5).priority(999).constraint
            self.heightPriorityImageConstraint = $0.height.equalToSuperview().multipliedBy(0.5).priority(999).constraint
            $0.top.equalToSuperview().offset(16).priority(900)
            self.centerYPriorityImageConstraint = $0.centerY.equalToSuperview().priority(999).constraint
        }

        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.iconImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(CashFlowCategoryStruct.itemSize.width - 16)
            self.titleLabelBottomConstraint = $0.bottom.equalToSuperview().offset(-8).constraint
        }

        self.container.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(100)
            $0.left.equalToSuperview().priority(900)
            $0.right.equalTo(view.snp.left).priority(900)
            
            self.containerLeftConstraint = $0.left.equalTo(view.snp.left).priority(999).constraint
            self.containerRightConstraint = $0.right.equalTo(view.snp.right).priority(999).constraint
        }

        self.categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }

        self.priceLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        if self.transition {
            self.dismissAnimate()
        } else {
            self.presentAnimate()
        }
    }
    
    private func displayModel() {
        self.titleLabel.text = self.model.serviceModel.title
        self.categoryLabel.text = self.model.serviceModel.title
        self.iconImageView.image = UIImage(named: self.model.serviceModel.imageName)
        //FIXME: Localized below
        self.priceLabel.text = "Расходы: " + self.model.price.stringValue + " ₽"
    }
}
