//  
//  SingleSelectionTableViewController.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SingleSelectionTableViewController
class SingleSelectionTableViewController: BaseViewController {
  var presenter: SingleSelectionTablePresenterProtocol!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.createUI()
  }
}

// MARK: - Privates
extension SingleSelectionTableViewController {
  private func createUI() {
    self.view.backgroundColor = .white
  }
}

// MARK: - SingleSelectionTableViewProtocol
extension SingleSelectionTableViewController: SingleSelectionTableViewProtocol { }
