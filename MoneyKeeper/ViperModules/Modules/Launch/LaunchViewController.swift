//
//  LaunchViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LaunchViewController
class LaunchViewController: BaseViewController {
    
    //Properties
    public var presenter: LaunchPresenterProtocol!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewLoaded()
    }
}

// MARK: - LaunchViewControllerProtocol
extension LaunchViewController: LaunchViewControllerProtocol { }
