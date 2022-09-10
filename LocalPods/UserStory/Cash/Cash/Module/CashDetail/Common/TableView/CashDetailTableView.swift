//
//  CashDetailTableView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import DesignSystem

final class CashDetailTableView: UIView {

  // MARK: - Proeprties

  private lazy var tableView: GradientTableView = {
    let tableView = GradientTableView(cells: [CashDetailTableCell.self], dataSource: self, delegate: self)
    tableView.backgroundColor = .clear
    tableView.separatorColor = .plainGray
    return tableView
  }()

  private lazy var dataSource: CashDetailTableDataSource = {
    CashDetailTableDataSource(tableView: tableView)
  }()

  // MARK: - Init

  init() {
    super.init(frame: .zero)

    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }

}

// MARK: - Reload data

extension CashDetailTableView {

  func reloadData(_ models: [CashModel]) {
    dataSource.reloadModels(models) { [weak self] in
      guard let self = self else { return }
      self.tableView.setTopGradientPoint(self.tableView)
      self.tableView.setBottomGradientPoint(self.tableView)
    }
  }

}

// MARK: - Private

private extension CashDetailTableView {

  func createUI() {
    addSubview(tableView)

    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: leftAnchor),
      tableView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }

}

// MARK: - UITableViewDataSource

extension CashDetailTableView: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    dataSource.numberOfSections()
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    dataSource.heightForHeaderInSection(section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    dataSource.viewForHeaderInSection(section)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.numberOfRowsInSection(section)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    dataSource.heightForRowAt(indexPath)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    dataSource.cellForRowAt(indexPath, tableView: tableView)
  }

}

// MARK: - UITableViewDelegate

extension CashDetailTableView: UITableViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    tableView.setTopGradientPoint(scrollView)
    tableView.setBottomGradientPoint(scrollView)
  }

}
