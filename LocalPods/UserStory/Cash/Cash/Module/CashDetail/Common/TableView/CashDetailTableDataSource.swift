//
//  CashDetailTableDataSource.swift
//  MoneyKeeper
//
//  Created by admin on 09.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
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
    let section = sections[section]
    let date = section.date
    let price = section.models.compactMap { $0.price }.reduce(0, +)
    let priceString = price.toString(.currency).map { ": " + $0 } ?? ""
    let title = date.asString(dateFormat: "dd.MM.yyyy") + priceString

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
    90
  }
  
  func cellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CashDetailTableCell {
    let cell: CashDetailTableCell = tableView.dequeueCell(indexPath: indexPath)
    let model = sections[indexPath.section].models[indexPath.row]
    cell.cashModel = model
    cell.contentView.backgroundColor = .darkViolet
    return cell
  }

}

// MARK: - Reload

extension CashDetailTableDataSource {

  func reloadModels(_ models: [CashModel], completion: @escaping () -> Void) {
    let sortedModels = models.sorted { $0.date > $1.date }
    let sortedDates = sortedModels.compactMap { $0.date.startOfDay }.removeDuplicates()
    sections = sortedDates.compactMap { date in
      CashDetailTableSection(
        date: date,
        models: models.filter { $0.date.startOfDay == date }
      )
    }

    CATransaction.begin()
    CATransaction.setCompletionBlock { completion() }
    tableView.reloadData()
    CATransaction.commit()
  }
}
