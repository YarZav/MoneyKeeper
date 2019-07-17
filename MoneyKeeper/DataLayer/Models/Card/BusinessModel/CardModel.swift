//
//  CardModel.swift
//  MoneyKeeper
//
//  Created by admin on 27/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

//MARK: - CardModel
class CardModel {
    
    /// Identifier of model
    var id: String = UUID().uuidString
    
    /// Type of bar code
    var codeType: Int16
    
    /// Value of bar code
    var codeValue: String
    
    //Init
    init(id: String, codeType: Int16, codeValue: String) {
        self.id = id
        self.codeType = codeType
        self.codeValue = codeValue
    }
}
