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
    var controllerTitle: String?
    private var tableView: UITableView!
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    private var models = [SingleSelectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded()
    }
}

// MARK: - Privates
extension SingleSelectionTableViewController {
    
    /// Create UI
    private func createUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = self.controllerTitle?.localized()
        
        //FIXME: MB create method with image
        let image = UIImage(named: "BackBlack")?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.backAction))
        self.navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        
        self.tableView = UITableView(cells: [UITableViewCell.self], dataSource: self, delegate: self, allowsSelection: true)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
        }
    }
    
    /// Show loader view when select on row wait come callback
    private func showLoaderView() {
        if !self.view.subviews.contains(self.activityIndicator) {
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.snp.makeConstraints {
                $0.edges.equalTo(self.tableView)
            }
        }
        self.activityIndicator.startAnimating()
    }
    
    /// Hide loader view if it was showed
    private func hideLoaderView() {
        if self.view.subviews.contains(self.activityIndicator) {
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.removeFromSuperview()
    }
    
    /// Select model after callback return in select
    internal func selectModel(at indexPath: IndexPath) {
        self.models[indexPath.row].setSelection(true)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        if let cell = self.tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    /// Deselect previous model
    private func deselectModel(at indexPath: IndexPath) {
        self.models[indexPath.row].setSelection(false)
        self.tableView.deselectRow(at: indexPath, animated: false)
        if let cell = self.tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}

// MARK: - SingleSelectionTableViewProtocol
extension SingleSelectionTableViewController: SingleSelectionTableViewProtocol {
    
    /// Update localized string
    func updateLocalizedStrings() {
        self.navigationItem.title = self.controllerTitle?.localized()
        self.presenter.viewLoaded()
    }
    
    /// Insert new models
    func insertModels(_ models: [SingleSelectionModel]) {
        self.models = models
        self.tableView.reloadData()
    }
    
    /// Select new model
    func setSelectedModel(at indexPath: IndexPath, oldIndexPath: IndexPath?) {
        if let oldIndexPath = oldIndexPath {
            self.deselectModel(at: oldIndexPath)
        }
        self.selectModel(at: indexPath)
        self.hideLoaderView()
    }
}

// MARK: - UITableViewDataSource
extension SingleSelectionTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.models[indexPath.row].isSelection() {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueCell(indexPath: indexPath)
        cell.textLabel?.text = self.models[indexPath.row].getTitle()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SingleSelectionTableViewController: UITableViewDelegate {
    
    /// Will select and wait callback for selection
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.showLoaderView()
        let oldIndexPath = self.tableView.indexPathForSelectedRow
        self.presenter.willSelectRow(at: indexPath, oldIndexPath: oldIndexPath)
        return nil
    }
}
