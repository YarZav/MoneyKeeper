//
//  BasePresenter.swift
//  MoneyKeeper
//
//  Created by admin on 19.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - BasePresenter
class BasePresenter {

    //Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
