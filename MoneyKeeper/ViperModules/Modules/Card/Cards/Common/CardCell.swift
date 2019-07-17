//
//  CardCell.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import AVFoundation
import EANBarcodeGenerator

// MARK: - CardCell
class CardCell: UICollectionViewCell {
    
    // Properties
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    private var codeLabel = UILabel()
    
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
extension CardCell {
    
    private func createUI() {
        self.contentView.cornerRadius(16, color: .white)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-32)
        }
        
        self.titleLabel.textAlignment = .center
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.imageView.snp.top).offset(-8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        self.codeLabel.textAlignment = .center
        self.contentView.addSubview(self.codeLabel)
        self.codeLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
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

// MARK: - Publics
extension CardCell {
    
    public func display(_ model: CardModel) {
        self.titleLabel.text = model.title
        self.imageView.image = self.generateBarCode(from: model.code)
        self.codeLabel.text = model.code
    }
}
