//
//  CashFlowDetailTableView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailTableDelegate
protocol CashFlowDetailTableDelegate: class {
    func deleteModel(_ model: CashFlowModel)
}

// MARK: - CashFlowDetailTableView
class CashFlowDetailTableView: UIView {
    
    //Proeprties
    private var tableView: UITableView!
    private var dataSource: CDCashFlowDetailTableDataSource!
    public weak var delegate: CashFlowDetailTableDelegate?

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowDetailTableView {
    
    public func displayModels(_ models: [CashFlowModel]) {
        self.dataSource.reloadModels(models)
        self.tableView.reloadData()
    }
}

// MARK: - Privates
extension CashFlowDetailTableView {
    
    private func createUI() {
        self.tableView = UITableView.make(cells: [CashFlowDetailTableCell.self], dataSource: self, delegate: self)
        self.tableView.backgroundColor = .clear
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.dataSource = CDCashFlowDetailTableDataSource()
    }
}

// MARK: - UITableViewDataSource
extension CashFlowDetailTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.dataSource.heightForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource.titleForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataSource.heightForRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSource.cellForRowAt(indexPath, tableView: tableView)
    }
}

// MARK: - UITableViewDelegate
extension CashFlowDetailTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delegate?.deleteModel(self.dataSource.getModelAt(indexPath))
            self.dataSource.deleteRowAt(indexPath, tableView: tableView)
        }
    }
}
