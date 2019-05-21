//
//  UITableView+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 29.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

extension UITableView {
    
    //FIXME: не статичный метод
    static func make(cells: [AnyClass], dataSource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil) -> UITableView {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        cells.forEach { cellClass in
            guard let casted = cellClass.self as? UITableViewCell.Type else { return }
            let reuseIdentifier = String(describing: casted.self)
            tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        }

        return tableView
    }

    /// Get cell for UItableView for IndexPath
    func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
