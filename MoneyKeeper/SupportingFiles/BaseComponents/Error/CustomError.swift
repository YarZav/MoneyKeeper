//
//  CustomError.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 12/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - OurErrorProtocol
protocol CustomErrorProtocol: LocalizedError {
    
    /// Get title for custom error
    var title: String? { get }
    
    /// Get code for custom error
    var code: Int { get }
}

// MARK: - Custom error
struct CustomError: CustomErrorProtocol {
    
    /// Title for custom error
    var title: String?
    
    /// Code for custom error
    var code: Int
    
    /// Error description for custom error
    var errorDescription: String? { return _description }
    
    /// failure reason for custom error
    var failureReason: String? { return _description }
    
    /// Private description for custom error
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
