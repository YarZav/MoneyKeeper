//
//  HeaderView.swift
//  MoneyKeeper
//
//  Created by admin on 17/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - HeaderView
class HeaderView: UIView {
    
    private let label = UILabel(font: UIFont.systemFont(ofSize: 17))
    
    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Public
extension HeaderView {
    
    public func updateTextColor(_ color: UIColor) {
        self.label.textColor = color
    }
    
    public func updateText(_ text: String?) {
        self.label.text = text
    }
}

// MARK: - Privates
extension HeaderView {
    
    private func createUI() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        let separateLine = UIView(backgroundColor: .lightGray)
        self.addSubview(separateLine)
        separateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
