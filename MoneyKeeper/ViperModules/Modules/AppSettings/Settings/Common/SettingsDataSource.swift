//
//  SettingsDataSource.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsDataSource
class SettingsDataSource {
    
    public weak var delegate: BaseSwitchCellDelegate?
    private var settingsManager = SettingsManager.sharedInstance
    
    init(delegate: BaseSwitchCellDelegate?) {
        self.delegate = delegate
    }
}

// MARK: - Publics
extension SettingsDataSource {
    
    public func numberOfSections() -> Int {
        return SettingsSections.allCases.count
    }
    
    public func heightForHeaderInSection(_ section: Int) -> CGFloat {
        return 44
    }
    
    public func viewForHeaderInSection(_ section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.backgroundColor = .blueGray
        headerView.updateText(SettingsSections(rawValue: section)?.title)
        headerView.updateTextColor(.white)
        return headerView
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        switch SettingsSections(rawValue: section) {
        case .general?: return SettingsGeneralRows.allCases.count
        case .storage?: return SettingsStorageRows.allCases.count
        case .security?: return SettingsSecurityRows.allCases.count
        case .other?: return SettingsOtherRows.allCases.count
        default: return 0
        }
    }
    
    public func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let settingsModel = self.settingsManager.getSettings() else {
            fatalError("Settings do not created for user")
        }
        
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            switch SettingsGeneralRows(rawValue: indexPath.row) {
            case .language?, .currency?: return self.discloserCell(indexPath: indexPath, tableView: tableView)
            case .push?: return self.switchCell(indexPath: indexPath, tableView: tableView, isOn: settingsModel.push)
            default: fatalError("Unavailable cell")
            }
            
        case .storage?:
            switch SettingsStorageRows(rawValue: indexPath.row) {
            case .iCloud?: return self.switchCell(indexPath: indexPath, tableView: tableView, isOn: false)
            case .delete?: return self.discloserCell(indexPath: indexPath, tableView: tableView)
            default: fatalError("Unavailable cell")
            }
            
        case .security?:
            switch SettingsSecurityRows(rawValue: indexPath.row) {
            case .pinCode?, .touchID?: return self.switchCell(indexPath: indexPath, tableView: tableView, isOn: false)
            default: fatalError("Unavailable cell")
            }
            
        case .other?:
            switch SettingsOtherRows(rawValue: indexPath.row) {
            case .about?, .review?: return self.discloserCell(indexPath: indexPath, tableView: tableView)
            case .hint?: return self.switchCell(indexPath: indexPath, tableView: tableView, isOn: false)
            default: fatalError("Unavailable cell")
            }
            
        default:
            fatalError("Unavailable cell")
        }
    }
    
    public func canSelectRow(indexPath: IndexPath, tableView: UITableView) -> Bool {
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            switch SettingsGeneralRows(rawValue: indexPath.row) {
            case .language?, .currency?: return true
            default: return false
            }
            
        case .storage?:
            switch SettingsStorageRows(rawValue: indexPath.row) {
            case .iCloud?: return false
            case .delete?: return true
            default: return false
            }
            
        case .security?:
            switch SettingsSecurityRows(rawValue: indexPath.row) {
            case .pinCode?: return true
            default: return false
            }
            
        case .other?:
            switch SettingsOtherRows(rawValue: indexPath.row) {
            case .about?, .review?: return true
            default: return false
            }
            
        default:
            return false
        }
    }
}

// MARK: - Privates
extension SettingsDataSource {
    
    private func getTitle(for indexPath: IndexPath) -> String? {
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            return SettingsGeneralRows(rawValue: indexPath.row)?.title
            
        case .storage?:
            return SettingsStorageRows(rawValue: indexPath.row)?.title
            
        case .security?:
            return SettingsSecurityRows(rawValue: indexPath.row)?.title
            
        case .other?:
            return SettingsOtherRows(rawValue: indexPath.row)?.title
            
        default:
            return nil
        }
    }
    
    private func getColor(for indexPath: IndexPath) -> UIColor? {
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            return SettingsGeneralRows(rawValue: indexPath.row)?.color
            
        case .storage?:
            return SettingsStorageRows(rawValue: indexPath.row)?.color
            
        case .security?:
            return SettingsSecurityRows(rawValue: indexPath.row)?.color
            
        case .other?:
            return SettingsOtherRows(rawValue: indexPath.row)?.color
            
        default:
            return nil
        }
    }
    
    private func getImage(for indexPath: IndexPath) -> UIImage? {
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            return SettingsGeneralRows(rawValue: indexPath.row)?.image
            
        case .storage?:
            return SettingsStorageRows(rawValue: indexPath.row)?.image
            
        case .security?:
            return SettingsSecurityRows(rawValue: indexPath.row)?.image
            
        case .other?:
            return SettingsOtherRows(rawValue: indexPath.row)?.image
            
        default:
            return nil
        }
    }
    
    private func discloserCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell: SettingsDiscloserCell = tableView.dequeueCell(indexPath: indexPath)
        cell.display(title: self.getTitle(for: indexPath), color: self.getColor(for: indexPath), image: self.getImage(for: indexPath))
        return cell
    }
    
    private func switchCell(indexPath: IndexPath, tableView: UITableView, isOn: Bool) -> UITableViewCell {
        let cell: SettingsSwitchCell = tableView.dequeueCell(indexPath: indexPath)
        cell.display(title: self.getTitle(for: indexPath), isOn: isOn, color: self.getColor(for: indexPath), image: self.getImage(for: indexPath))
        cell.delegate = self.delegate
        return cell
    }
}
