//  
//  SingleSelectionTableProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SingleSelectionModel
protocol SingleSelectionModel { }

// VIEW -> PRESENTER
protocol SingleSelectionTablePresenterProtocol: class { }

// PRESENTER -> VIEW
protocol SingleSelectionTableViewProtocol: BaseViewControllerProtocol { }

// PRESENTER -> WIREFRAME
protocol SingleSelectionTableWireFrameProtocol: class { }

// INTERACTOR -> PRESENTER
protocol SingleSelectionTableInteractorProtocol: class { }
