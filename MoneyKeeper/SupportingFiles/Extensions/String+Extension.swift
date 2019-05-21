//
//  String+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension String {
    
    /// String to double
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
