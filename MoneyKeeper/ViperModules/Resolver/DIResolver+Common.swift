//
//  DIResolver+Common.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsDIResolver
extension DIResolver {
    
    // Singe selection table view controller
    func singleSelectionTableViewCotnroller(title: String, interactor: SingleSelectionTableInteractorProtocol) -> UIViewController {
        let view = SingleSelectionTableViewController()
        let wireFrame = SingleSelectionTableWireFrame(resolver: self)
        let presenter = SingleSelectionTablePresenter(view: view, wireFrame: wireFrame, interactor: interactor)
        
        view.presenter = presenter
        view.controllerTitle = title
        
        return view
    }
}
