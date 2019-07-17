//  
//  SettingsViewController.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import MessageUI

// MARK: - 
class SettingsViewController: BaseViewController {
    
    var presenter: SettingsPresenterProtocol!
    private var tableView: UITableView!
    private var dataSource: SettingsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
}

// MARK: - Privates
extension SettingsViewController {
    
    private func createUI() {
        self.navigationItem.title = "SettingsTitle".localized()
        self.view.backgroundColor = .lightBlue
        
        self.dataSource = SettingsDataSource(delegate: self)
        self.tableView = UITableView(cells: [SettingsDiscloserCell.self, SettingsSwitchCell.self], dataSource: self, delegate: self, allowsSelection: true)
        self.tableView.backgroundColor = .clear
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
        }
    }
    
    private func selectRow(indexPath: IndexPath, tableView: UITableView, isOn: Bool) {
        switch SettingsSections(rawValue: indexPath.section) {
        case .general?:
            switch SettingsGeneralRows(rawValue: indexPath.row) {
            case .language?: self.presenter.presentLanguage()
            case .currency?: self.presenter.presentCurrency()
            case .push?: self.presenter.enabledlocalPush(isOn)
            default: break
            }
            
        case .storage?:
            switch SettingsStorageRows(rawValue: indexPath.row) {
            case .iCloud?: break
            case .delete?: self.showDeleteAlert()
            default: break
            }
            
        case .security?:
            switch SettingsSecurityRows(rawValue: indexPath.row) {
            case .pinCode?: break//cell.accessoryType = .disclosureIndicator
            case .touchID?: break
            default: break
            }
            
        case .other?:
            switch SettingsOtherRows(rawValue: indexPath.row) {
            case .about?: self.presenter.presentAboutProgram()
            case .review?: self.presentReview()
            case .hint?: break
            default: break
            }
            
        default:
            break
        }
    }
    
    private func showDeleteAlert() {
        let alertController = UIAlertController(title: "SettingsWarning".localized(), message: "SettingsCoreDataDelete".localized(), preferredStyle: .alert)
        let noAction =  UIAlertAction(title: "SettingsYes".localized(), style: .cancel) { [weak alertController] (_) in
            alertController?.dismiss(animated: false, completion: { })
        }
        let yesAction = UIAlertAction(title: "SettingsYes".localized(), style: .destructive) { [weak self] (_) in
            self?.presenter.clearUserData()
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentReview() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setSubject("Money Keeper")
            present(mail, animated: true)
        } else {
            self.showOkAlertController(title: "SettingsWarning".localized(), message: nil, handler: { })
        }
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    
    func updateLocalizedString() {
        self.navigationItem.title = "SettingsTitle".localized()
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    
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
        return self.dataSource.tableCell(indexPath: indexPath, tableView: tableView)
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return self.dataSource.canSelectRow(indexPath: indexPath, tableView: tableView) ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow(indexPath: indexPath, tableView: tableView, isOn: false)
    }
}

// MARK: - BaseSwitchCellDelegate
extension SettingsViewController: BaseSwitchCellDelegate {

    func didSelectSwitch(isOn: Bool, cell: BaseSwitchCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.selectRow(indexPath: indexPath, tableView: self.tableView, isOn: isOn)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
