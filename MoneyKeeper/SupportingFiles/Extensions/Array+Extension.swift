//
//  Array+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    
    /// Remove duplicate items for array
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
