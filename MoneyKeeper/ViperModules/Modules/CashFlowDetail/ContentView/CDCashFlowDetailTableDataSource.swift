//
//  CDCashFlowDetailTableDataSource.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CDCashFlowDetailTableDataSource
class CDCashFlowDetailTableDataSource {
    
    //Properties
    private var sections = [(Date, [CashFlowModel])]()
    
    //Init
    init() { }
}

// MARK: - Table protocol
extension CDCashFlowDetailTableDataSource {
    
    public func numberOfSections() -> Int {
        return self.sections.count
    }
    
    public func titleForHeaderInSection(_ section: Int) -> String? {
        let date = self.sections[section].0
        return date.asString(dateFormat: "dd.MM.yyyy")
    }
    
    public func heightForHeaderInSection(_ section: Int) -> CGFloat {
        return 44.0
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        let modelsInSection = self.sections[section].1
        return modelsInSection.count
    }
    
    public func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    public func cellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CashFlowDetailTableCell {
        let cell: CashFlowDetailTableCell = tableView.dequeueCell(indexPath: indexPath)
        let section = self.sections[indexPath.section]
        let model = section.1[indexPath.row]
        
        cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? .darkViolet : .darkGray
        cell.display(imageName: model.serviceModel.imageName, price: model.getPriceAsString(numberStyle: .currency), category: model.serviceModel.title)
        
        return cell
    }
}

extension CDCashFlowDetailTableDataSource {
    
    public func reloadModels(_ models: [CashFlowModel]) {
        self.sections = [(Date, [CashFlowModel])]()
        
        let sortedModels = models.sorted { $0.date > $1.date }
        let startOfDates = (sortedModels.compactMap { $0.date.startOfDay }).removeDuplicates()
        
        for startOfDate in startOfDates {
            let filteredModels = sortedModels.filter { $0.date.startOfDay == startOfDate }
            
            if !filteredModels.isEmpty {
                let section: (Date, [CashFlowModel]) = (startOfDate, filteredModels)
                self.sections.append(section)
            }
        }
    }
    
    public func deleteRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        tableView.beginUpdates()

        self.sections[indexPath.section].1.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)

        if self.sections[indexPath.section].1.isEmpty {
            self.sections.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
        
        tableView.endUpdates()
    }
    
    public func getModelAt(_ indexPath: IndexPath) -> CashFlowModel {
        let section = self.sections[indexPath.section]
        let model = section.1[indexPath.row]
        return model
    }
}
