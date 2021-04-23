//
//  CDCashFlowDetailTableDataSource.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// MARK: - Cash flow detail section model
class CashFlowDetailSection {
    
    var date: Date
    var models = [CashModel]()
    
    init(date: Date) {
        self.date = date
    }
}

// MARK: - CDCashFlowDetailTableDataSource
class CashFlowDetailTableDataSource {
    
    //Properties
    private var tableView: UITableView
    private var sections = [CashFlowDetailSection]()
    
    //Init
    init(tableView: UITableView) {
        self.tableView = tableView
    }
}

// MARK: - Privates
extension CashFlowDetailTableDataSource {
    
    private func insertNewModel(_ model: CashModel, sectionIndex: Int) {
        let newSection = CashFlowDetailSection(date: model.date.startOfDay)
        newSection.models.append(model)
        self.sections.insert(newSection, at: sectionIndex)
    }
    
    private func getAllModels() -> [CashModel] {
        var models = [CashModel]()
        self.sections.forEach { models.append(contentsOf: $0.models) }
        return models
    }
}

// MARK: - Table protocol
extension CashFlowDetailTableDataSource {
    
    public func numberOfSections() -> Int {
        return self.sections.count
    }
    
    public func viewForHeaderInSection(_ section: Int) -> UIView? {
        let date = self.sections[section].date
        let title = date.asString(dateFormat: "dd.MM.yyyy")

        let headerView = HeaderView()
        headerView.backgroundColor = .anthracite
        headerView.updateTextColor(.white)
        headerView.updateText(title)
        
        return headerView
    }
    
    public func heightForHeaderInSection(_ section: Int) -> CGFloat {
        return 44.0
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return self.sections[section].models.count
    }
    
    public func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    public func cellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CashFlowDetailTableCell {
        let cell: CashFlowDetailTableCell = tableView.dequeueCell(indexPath: indexPath)
        let model = self.sections[indexPath.section].models[indexPath.row]
        cell.contentView.backgroundColor = .darkViolet
//        cell.display(imageName: model.categoryModel.imageName, price: model.getPriceAsString(numberStyle: .currency), category: model.categoryModel.title.localized())
        return cell
    }
}

//MARK: - Insert/Delete
extension CashFlowDetailTableDataSource {
    
    public func insertModels(_ models: [CashModel], completion: @escaping () -> Void) {
        //FIXME: In Queue
        if models.isEmpty {
            completion()
            return
        }
        
        let allModels = self.getAllModels()
//        let sortedModels = models.sorted { $0.date > $1.date }.filter { (model) in
//            !allModels.contains(where: { (allModel) -> Bool in
//                allModel.id == model.id
//            })
//        }
//
//        if sortedModels.isEmpty {
//            completion()
//            return
//        }
//
//        var insertedRows = [IndexPath]()
//        let insertedSection = NSMutableIndexSet()
//        var newRowModels = [CashModel]()
//        var newSectionModels = [CashModel]()
//
//        for model in sortedModels {
//            //Add model in created section
//            if let sectionIndex = self.sections.firstIndex(where: { $0.date.startOfDay == model.date.startOfDay }) {
//                if let rowIndex = self.sections[sectionIndex].models.lastIndex(where: { $0.date > model.date }) {
//                    self.sections[sectionIndex].models.insert(model, at: rowIndex)
//                    newRowModels.append(model)
//                } else {
//                    self.sections[sectionIndex].models.append(model)
//                    newRowModels.append(model)
//                }
//                continue
//            }
//
//            // Creatse new section with date before
//            if let sectionIndex = self.sections.lastIndex(where: { $0.date.startOfDay > model.date.startOfDay }) {
//                self.insertNewModel(model, sectionIndex: sectionIndex)
//                newSectionModels.append(model)
//            } else {
//                self.insertNewModel(model, sectionIndex: 0)
//                newSectionModels.append(model)
//            }
//        }
//
//        for newRowModel in newRowModels {
//            for (sectionIndex, section) in self.sections.enumerated() {
//                for (rowIndex, model) in section.models.enumerated() {
//                    if newRowModel.id == model.id {
//                        insertedRows.append(IndexPath(row: rowIndex, section: sectionIndex))
//                    }
//                }
//            }
//        }
//
//        for newSectionModel in newSectionModels {
//            for (sectionIndex, section) in self.sections.enumerated() {
//                for (rowIndex, model) in section.models.enumerated() {
//                    if newSectionModel.id == model.id {
//                        insertedRows.append(IndexPath(row: rowIndex, section: sectionIndex))
//                        insertedSection.add(sectionIndex)
//                    }
//                }
//            }
//        }
        
        //FIXME: Reuse in method
        CATransaction.begin()
        self.tableView.beginUpdates()
        CATransaction.setCompletionBlock {
            completion()
        }
//        self.tableView.insertSections(insertedSection as IndexSet, with: .automatic)
//        self.tableView.insertRows(at: insertedRows, with: .automatic)
        self.tableView.endUpdates()
        CATransaction.commit()
    }
    
    public func deleteModels(at indexPaths: [IndexPath], completion: @escaping () -> Void) {
        //FIXME: In Queue
        if indexPaths.isEmpty {
            completion()
            return
        }
        
        let sortedIndexPaths = indexPaths.sorted { $0 < $1 }
        let deletedSection = NSMutableIndexSet()
        
        for indexPath in sortedIndexPaths {
            self.sections[indexPath.section].models.remove(at: indexPath.row)
            if self.sections[indexPath.section].models.isEmpty {
                self.sections.remove(at: indexPath.section)
                deletedSection.add(indexPath.section)
            }
        }
        
        //FIXME: Reuse in method
        CATransaction.begin()
        self.tableView.beginUpdates()
        CATransaction.setCompletionBlock {
            completion()
        }
        self.tableView.deleteRows(at: indexPaths, with: .automatic)
        self.tableView.deleteSections(deletedSection as IndexSet, with: .automatic)
        self.tableView.endUpdates()
        CATransaction.commit()
    }
    
    public func deleteModels(at models: [CashModel], completion: @escaping () -> Void) {
        //FIXME: In Queue
        if models.isEmpty {
            completion()
            return
        }
        
//        var deletedIndexPaths = [IndexPath]()
//        for model in models {
//            for (sectionIndex, section) in self.sections.enumerated() {
//                for (rowIndex, sectionModel) in section.models.enumerated() {
//                    if model.id == sectionModel.id {
//                        deletedIndexPaths.append(IndexPath(row: rowIndex, section: sectionIndex))
//                    }
//                }
//            }
//        }
        
//        self.deleteModels(at: deletedIndexPaths, completion: completion)
    }
    
    public func getModelAt(_ indexPath: IndexPath) -> CashModel {
        return self.sections[indexPath.section].models[indexPath.row]
    }
}
