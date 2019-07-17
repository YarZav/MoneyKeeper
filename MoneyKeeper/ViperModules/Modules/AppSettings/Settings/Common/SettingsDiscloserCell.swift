//
//  SettingsDiscloserCell.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsDiscloserCell
class SettingsDiscloserCell: BaseTableCell {
    
    private var backgroundImageView = UIView()
    private var iconImageView = UIImageView()
    private var titleLabel = UILabel()

    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension SettingsDiscloserCell {
    
    public func display(title: String?, color: UIColor?, image: UIImage?) {
        self.titleLabel.text = title
        self.backgroundImageView.backgroundColor = color
        self.iconImageView.image = image
    }
}

// MARK: - Privates
extension SettingsDiscloserCell {
    
    private func createUI() {
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .lightBlue

        self.backgroundImageView.layer.cornerRadius = 3
        self.contentView.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(34)
        }
        
        self.backgroundImageView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.backgroundImageView.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
