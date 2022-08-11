//
//  Thread+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 07/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension Thread {
    
    /// Do code block in main thread
    func doInMainThread(_ codeBlock: @escaping () -> Void) {
        if self.isMainThread {
            codeBlock()
        } else {
            DispatchQueue.main.async {
                codeBlock()
            }
        }
    }
}
