//
//  CashFlowDetailTableView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

//FIXME: Create loader

// MARK: - CashFlowDetailTableDelegate
protocol CashFlowDetailTableDelegate: class {
    func deleteModel(_ model: CashFlowModel)
}

// MARK: - CashFlowDetailTableView
class CashFlowDetailTableView: UIView {
    
    //Proeprties
    private var tableView: UITableView!
    private var dataSource: CashFlowDetailTableDataSource!
    public weak var delegate: CashFlowDetailTableDelegate?

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension CashFlowDetailTableView {
    
    public func insertModels(_ models: [CashFlowModel], completion: @escaping () -> Void) {
        self.dataSource.insertModels(models, completion: completion)
    }
    
    public func deleteModels(_ models: [CashFlowModel], completion: @escaping () -> Void) {
        self.dataSource.deleteModels(at: models, completion: completion)
    }
    
    public func updateStringLocalization() {
        self.tableView.reloadData()
    }
}

// MARK: - Privates
extension CashFlowDetailTableView {
    
    private func createUI() {
        self.tableView = UITableView(cells: [CashFlowDetailTableCell.self], dataSource: self, delegate: self)
        self.dataSource = CashFlowDetailTableDataSource(tableView: self.tableView)
        self.tableView.backgroundColor = .clear
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.dataSource.viewForHeaderInSection(section)
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
            let model = self.dataSource.getModelAt(indexPath)
            self.dataSource.deleteModels(at: [indexPath]) {
                self.delegate?.deleteModel(model)
            }
        }
    }
}
