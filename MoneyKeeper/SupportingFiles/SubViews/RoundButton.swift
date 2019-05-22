//
//  RoundButton.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 11.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MAKR: - RoundButton
class RoundButton: UIButton {
    
    //Properties
    var bckGroundColor: UIColor = .white

    //Init
    init(backgroundColor: UIColor, radius: CGFloat, borderColor: UIColor) {
        super.init(frame: .zero)
        self.createUI(backgroundColor: backgroundColor, radius: radius, borderColor: borderColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates
extension RoundButton {
    
    private func createUI(backgroundColor: UIColor, radius: CGFloat, borderColor: UIColor) {
        self.bckGroundColor = backgroundColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        
        self.snp.makeConstraints {
            $0.height.equalTo(radius * 2)
            $0.width.equalTo(radius * 2)
        }
    }
}
