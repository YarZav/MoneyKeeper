//
//  HightLightRoundButton.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - Hightlight round button
class HightLightRoundButton: RoundButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : self.bckGroundColor
        }
    }
}
