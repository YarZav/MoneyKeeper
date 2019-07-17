//  
//  SingleSelectionTableProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SingleSelectionModel
protocol SingleSelectionModel {
    func getTitle() -> String
    func isSelection() -> Bool
    func setSelection(_ selection: Bool)
}

// VIEW -> PRESENTER
protocol SingleSelectionTablePresenterProtocol: class {
    func viewLoaded()
    func willSelectRow(at indexPath: IndexPath, oldIndexPath: IndexPath?)
}

// PRESENTER -> VIEW
protocol SingleSelectionTableViewProtocol: BaseViewControllerProtocol {
    func updateLocalizedStrings()
    func insertModels(_ models: [SingleSelectionModel])
    func setSelectedModel(at indexPath: IndexPath, oldIndexPath: IndexPath?)
}

// PRESENTER -> WIREFRAME
protocol SingleSelectionTableWireFrameProtocol: class { }

// INTERACTOR -> PRESENTER
protocol SingleSelectionTableInteractorProtocol: class {
    func getModels() -> [SingleSelectionModel]
    func didSelectModel(at indexPath: IndexPath, callback: @escaping (Error?) -> Void)
}
