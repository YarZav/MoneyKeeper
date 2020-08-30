//  
//  AboutProgramViewController.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - AboutProgramViewController
class AboutProgramViewController: BaseViewController {
    
    var presenter: AboutProgramPresenterProtocol!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.createUI()
    }
}

// MARK: - Privates
extension AboutProgramViewController {
    
    private func createUI() {
        self.view.backgroundColor = .lightBlue
        
        let threeCircleView = ThreeCircleView(first: .darkViolet, second: UIColor.white.withAlphaComponent(0.4), third: .white)
        self.view.addSubview(threeCircleView)
        threeCircleView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(191)
        }
        
        let titleLabel = UILabel(font: UIFont.systemFont(ofSize: 36))
        titleLabel.numberOfLines = 2
        titleLabel.text = "COIN\nWALLET"
        
        let appVersion = UILabel(font: UIFont.systemFont(ofSize: 17), textAlignment: .center)
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            appVersion.text = "v" + version + " (" + build + ")"
        }
        
        let descriptionLabel = UILabel(font: UIFont.systemFont(ofSize: 17), textColor: .white)
        descriptionLabel.text = "Description"
        
        let iconInfoText = NSMutableAttributedString(string: "AboutProgramIconInfo".localized())
        if let url = URL(string: "https://icons8.com/icons/ios") {
            let iconInfoLink = NSMutableAttributedString(string: "https://icons8.com/icons/ios", attributes: [NSAttributedString.Key.link: url])
            iconInfoText.append(iconInfoLink)
        }
        let iconInfo = UILabel(font: UIFont.systemFont(ofSize: 13), textColor: .darkGray, textAlignment: .center)
        iconInfo.numberOfLines = 0
        iconInfo.attributedText = iconInfoText
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(appVersion)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(iconInfo)
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(218)
            $0.centerX.equalTo(threeCircleView).priority(900)
            $0.centerY.equalTo(threeCircleView)
            $0.right.equalToSuperview()
        }
        
        appVersion.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(threeCircleView.snp.bottom)
        }
        
        iconInfo.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-self.getTabBarHeight() - 16)
        }
    }
}

// MARK: - AboutProgramViewProtocol
extension AboutProgramViewController: AboutProgramViewProtocol { }
