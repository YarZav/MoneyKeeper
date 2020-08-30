//  
//  SingleSelectionTableInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SingleSelectionTableInteractor
class SingleSelectionTableInteractor { }

// MARK: - SingleSelectionTableInteractorProtocol
extension SingleSelectionTableInteractor: SingleSelectionTableInteractorProtocol {
    
    func getModels() -> [SingleSelectionModel] {
        return []
    }
    
    func didSelectModel(at indexPath: IndexPath, callback: @escaping (Error?) -> Void) { }
}
