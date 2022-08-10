//
//  CashDetailTableDataSource.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business
import DesignSystem

final class CashDetailTableDataSource {

  // MARK: - Private properties

  private var tableView: UITableView
  private var sections = [CashDetailTableSection]()

  // MARK: - Init

  init(tableView: UITableView) {
    self.tableView = tableView
  }

}

// MARK: - Private

private extension CashDetailTableDataSource {

  var allModels: [CashModel] {
    sections.compactMap { $0.models }.reduce([], +)
  }

}

// MARK: - Table data source

extension CashDetailTableDataSource {

  func numberOfSections() -> Int {
    sections.count
  }

  func viewForHeaderInSection(_ section: Int) -> UIView? {
    let date = self.sections[section].date
    let title = date.asString(dateFormat: "dd.MM.yyyy")

    let headerView = HeaderView()
    headerView.backgroundColor = .anthracite
    headerView.updateTextColor(.white)
    headerView.updateText(title)

    return headerView
  }

  func heightForHeaderInSection(_ section: Int) -> CGFloat {
    44
  }

  func numberOfRowsInSection(_ section: Int) -> Int {
    sections[section].models.count
  }

  func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
    60
  }
  
  func cellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CashDetailTableCell {
    let cell: CashDetailTableCell = tableView.dequeueCell(indexPath: indexPath)
    let model = sections[indexPath.section].models[indexPath.row]
    let imageName = model.cashCategory?.imageName ?? ""
    let price = model.price.toString(.currency) ?? ""
    let cateogry = model.cashCategory?.title ?? ""
    cell.contentView.backgroundColor = .darkViolet
    cell.display(imageName: imageName, price: price, category: cateogry)
    return cell
  }

}

//MARK: - Insert

extension CashDetailTableDataSource {

  func insertModels(_ models: [CashModel], completion: @escaping () -> Void) {
    //FIXME: In Queue
    if models.isEmpty {
        completion()
        return
    }

    let sortedModels = models.sorted { $0.date > $1.date }
    let newModels = sortedModels.filter { sortedModel in
      !allModels.contains(where: { sortedModel.identifier == $0.identifier })
    }

    if newModels.isEmpty {
        completion()
        return
    }

    var insertedRows = [IndexPath]()
    let insertedSection = NSMutableIndexSet()
    var newRowModels = [CashModel]()
    var newSectionModels = [CashModel]()

    for model in newModels {
      let sectionIndex = sections.firstIndex(where: { $0.date.startOfDay == model.date.startOfDay })
      if let sectionIndex = sectionIndex {
        //Add model in created section
        let rowIndex = sections[sectionIndex].models.lastIndex(where: { $0.date > model.date })
        if let rowIndex = rowIndex {
          sections[sectionIndex].models.insert(model, at: rowIndex)
          newRowModels.append(model)
        } else {
          sections[sectionIndex].models.append(model)
          newRowModels.append(model)
        }
      } else {
        // Creatse new section with date before
        let newSectionIndex = sections.lastIndex(where: { $0.date.startOfDay > model.date.startOfDay })
        if let newSectionIndex = newSectionIndex {
          let newSection = CashDetailTableSection(date: model.date.startOfDay, models: [model])
          sections.insert(newSection, at: newSectionIndex)
          newSectionModels.append(model)
        } else {
          let newSection = CashDetailTableSection(date: model.date.startOfDay, models: [model])
          sections.insert(newSection, at: 0)
          newSectionModels.append(model)
        }
      }
    }

    for newRowModel in newRowModels {
      for (sectionIndex, section) in sections.enumerated() {
        for (rowIndex, model) in section.models.enumerated() {
          if newRowModel.identifier == model.identifier {
            insertedRows.append(IndexPath(row: rowIndex, section: sectionIndex))
          }
        }
      }
    }

    for newSectionModel in newSectionModels {
      for (sectionIndex, section) in sections.enumerated() {
        for (rowIndex, model) in section.models.enumerated() {
          if newSectionModel.identifier == model.identifier {
            insertedRows.append(IndexPath(row: rowIndex, section: sectionIndex))
            insertedSection.add(sectionIndex)
          }
        }
      }
    }

    //FIXME: Reuse in method
    CATransaction.begin()
    tableView.beginUpdates()
    CATransaction.setCompletionBlock {
      completion()
    }
    tableView.insertSections(insertedSection as IndexSet, with: .automatic)
    tableView.insertRows(at: insertedRows, with: .automatic)
    tableView.endUpdates()
    CATransaction.commit()
  }

}
