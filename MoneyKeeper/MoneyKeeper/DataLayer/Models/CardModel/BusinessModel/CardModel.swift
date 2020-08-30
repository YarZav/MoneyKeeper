//
//  CardModel.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation

// MARK: - CardModel
class CardModel {
    /// identifier of model
    var id: String = UUID().uuidString
    
    /// Date of add
    var addDate: Date
    
    /// Bar code value
    var code: String
    
    /// Bar code type
     var type: AVMetadataObject.ObjectType
    
    /// Name for bar code
    var title: String
    
    // Init
    init(code: String, type: AVMetadataObject.ObjectType, title: String) {
        self.code = code
        self.type = type
        self.title = title
        self.addDate = Date()
    }
}
