//
//  CardDetailView.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import EANBarcodeGenerator
import SnapKit
import Business

class CardDetailView: UIView {
    
//    private var model: CardModel!
    private var transition: Bool = false
    
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    private var codeLabel = UILabel()
    
    private var titleBottomSmallConstraint: Constraint!
    
    private var imageTopSmallConstraint: Constraint!
    private var imageBottomSmallConstraint: Constraint!
    private var imageCenterYBigConstraint: Constraint!
    private var imageHeightBigConstraint: Constraint!
    
    // Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(/*model: CardModel, */transition: Bool) {
        super.init(frame: .zero)
//        self.model = model
        self.transition = transition
        self.createUI()
        self.displayModel()
    }
}

// MARK: - Publics

extension CardDetailView {
    
    public func presentAnimate() {
        self.titleBottomSmallConstraint.deactivate()
        
        self.imageTopSmallConstraint.deactivate()
        self.imageBottomSmallConstraint.deactivate()
        self.imageCenterYBigConstraint.activate()
        self.imageHeightBigConstraint.activate()
        
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0

    }
    
    public func dismissAnimate() {
        self.titleBottomSmallConstraint.activate()

        self.imageTopSmallConstraint.activate()
        self.imageBottomSmallConstraint.activate()
        self.imageCenterYBigConstraint.deactivate()
        self.imageHeightBigConstraint.deactivate()
        
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
    }
}

// MARK: - Privates
extension CardDetailView {
    
    private func createUI() {
        self.cornerRadius(16, color: .white)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            self.imageTopSmallConstraint = $0.top.equalToSuperview().offset(32).priority(999).constraint
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            self.imageBottomSmallConstraint = $0.bottom.equalToSuperview().offset(-32).priority(999).constraint
            
            self.imageCenterYBigConstraint = $0.centerY.equalToSuperview().priority(900).constraint
            self.imageHeightBigConstraint = $0.height.equalTo(150).priority(900).constraint
        }
        
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            self.titleBottomSmallConstraint = $0.bottom.equalTo(self.imageView.snp.top).offset(-8).priority(999).constraint
            $0.bottom.equalTo(self.imageView.snp.top).offset(-60).priority(900)
            $0.width.equalTo(250)
            $0.centerX.equalTo(self.imageView)
        }
        
        self.codeLabel.textAlignment = .center
        self.addSubview(self.codeLabel)
        self.codeLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(8)
            $0.width.equalTo(250)
            $0.centerX.equalTo(self.imageView)
        }
        
        if self.transition {
            self.dismissAnimate()
        } else {
            self.presentAnimate()
        }
    }
    
    private func displayModel() {
//        self.titleLabel.text = model.title
//        self.imageView.image = self.generateBarCode(from: model.code)
//        self.codeLabel.text = model.code
    }
    
    private func generateBarCode(from string: String) -> UIImage? {
        CIEANBarcodeGenerator.register()
        let filter = CIFilter(name: "CIEANBarcodeGenerator")
        filter?.setValue(string, forKey: "inputMessage")
        if let ciImage = filter?.outputImage {
            return UIImage(ciImage: ciImage)
        } else {
            return nil
        }
    }
}
