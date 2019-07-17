//
//  LaunchProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

//Presenter -> View
protocol LaunchViewControllerProtocol: BaseViewControllerProtocol { }

//View -> Presenter
protocol LaunchPresenterProtocol {
    func viewLoaded()
}

//Presenter - Interactor
protocol LaunchInteractorProtocol {
    func createUserAccount(callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol LaunchWireFrameProtocol {
    func presentTabbarController()
}
