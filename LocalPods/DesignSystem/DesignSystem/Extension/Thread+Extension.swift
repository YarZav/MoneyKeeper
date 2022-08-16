//
//  Thread+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 07/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

extension Thread {
    
  /// Do code block in main thread
  func onMain(_ codeBlock: @escaping () -> Void) {
    if isMainThread {
      codeBlock()
    } else {
      DispatchQueue.main.async {
        codeBlock()
      }
    }
  }

}
