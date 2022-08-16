//
//  UITableView+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 29.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

public extension UITableView {

  /// Make UITableView
  ///
  /// - Parameters:
  ///     - cells: cell which can be displayed
  ///     - dataSource: UITableViewDataSource, default is nil
  ///     - delegate: UITableViewDelegate, default is nil
  ///     - allowsSelection: allows selection cells of not, default is false
  convenience init(cells: [AnyClass], dataSource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil, allowsSelection: Bool = false) {
      self.init()
      self.allowsSelection = allowsSelection
      self.dataSource = dataSource
      self.delegate = delegate
      cells.forEach { cellClass in
        guard let casted = cellClass.self as? UITableViewCell.Type else {
          fatalError("Cell is not inheritance from UITableCell")
        }
        let reuseIdentifier = String(describing: casted.self)
        self.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
      }
  }

  /// Get cell for UItableView for IndexPath
  ///
  /// - Parameters:
  ///     - indexPath: index path for cell
  func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
    let reuseIdentifier = String(describing: T.self)
    return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
  }

}
