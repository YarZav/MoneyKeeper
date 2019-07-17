//
//  LabelView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LabelView
class LabelView: UIView {
    
    private var label = UILabel(font: UIFont.systemFont(ofSize: 17), textColor: .white, textAlignment: .center)

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension LabelView {
    
    public func display(_ text: String?) {
        self.label.text = text?.localized()
    }
}

// MARK: - Privates
extension LabelView {
    
    private func createUI() {
        self.label.numberOfLines = 0
        self.addSubview(self.label)
        self.label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
