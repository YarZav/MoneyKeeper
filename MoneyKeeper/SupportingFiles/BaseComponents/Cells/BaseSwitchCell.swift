////
////  BaseSwitchCell.swift
////  MoneyKeeper
////
////  Created by admin on 04/06/2019.
////  Copyright © 2019 ZYG. All rights reserved.
////
//
//import UIKit
//
//// MARK: - BaseSwitchCellDelegate
//protocol BaseSwitchCellDelegate: class {
//    func didSelectSwitch(isOn: Bool, cell: BaseSwitchCell)
//}
//
//// MARK: - BaseSwitchCell
//class BaseSwitchCell: BaseTableCell {
//    
//    public weak var delegate: BaseSwitchCellDelegate?
//    public var titleLabel = UILabel()
//    public var switchView = UISwitch()
//
//    // Init
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.createUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//// MARK: - Publics
//extension BaseSwitchCell {
//    
//    public func display(title: String?, isOn: Bool) {
//        self.titleLabel.text = title
//        self.switchView.isOn = isOn
//    }
//}
//
//extension BaseSwitchCell {
//    
//    @objc private func didtapSwitch(_ sender: UISwitch) {
//        self.delegate?.didSelectSwitch(isOn: sender.isOn, cell: self)
//    }
//}
//
//// MARK: - Privates
//extension BaseSwitchCell {
//    
//    private func createUI() {
//        self.switchView.addTarget(self, action: #selector(didtapSwitch(_:)), for: .valueChanged)
//        self.contentView.addSubview(self.switchView)
//        self.switchView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.right.equalToSuperview().offset(-14)
//        }
//        
//        self.contentView.addSubview(self.titleLabel)
//        self.titleLabel.snp.makeConstraints {
//            $0.left.equalToSuperview().offset(15)
//            $0.right.equalTo(self.switchView.snp.left).offset(-8)
//            $0.top.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
//    }
//}
