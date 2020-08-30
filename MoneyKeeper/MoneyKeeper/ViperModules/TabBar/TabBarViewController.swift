//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarViewController
class TabBarViewController: BaseTabBarController {

    //Properties
    public var presenter: TabBarPresenterProtocol!
    public let navigationTypes: [TabBarButtonType] = [.cashFlow, .cashFlowDetail, .cards, .goals, .settings]

    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.addButtons(for: self.navigationTypes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.createTabBarControlelrs(for: self.navigationTypes)
    }
}

// MARK: - Privates
extension TabBarViewController {
    
    private func addButtons(for types: [TabBarButtonType]) {
        var previousButton: UIButton?
        
        for (index, type) in types.enumerated() {
            let tabBarButton = self.createTabBarButton(type: type)
            self.tabBar.addSubview(tabBarButton)
            self.tabBar.bringSubviewToFront(tabBarButton)
            
            tabBarButton.snp.makeConstraints {
                if let prevButton = previousButton {
                    $0.width.equalTo(prevButton.snp.width)
                    $0.left.equalTo(prevButton.snp.right)
                } else {
                    $0.left.equalToSuperview()
                }
                
                if index == types.count - 1 {
                    $0.right.equalToSuperview()
                }

                $0.top.bottom.equalToSuperview()
            }
            
            previousButton = tabBarButton
        }
    }
    
    private func createTabBarButton(type: TabBarButtonType) -> UIButton {
        let image = type.image?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .custom)
        button.backgroundColor = type.color
        button.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tag = type.tag
        return button
    }
    
    private func enableButton(by index: Int) {
        guard let type = TabBarButtonType(rawValue: index) else { return }
        self.navigationTypes.forEach {
            if let button = self.view.viewWithTag($0.tag) as? UIButton {
                if $0 == type {
                    button.setImage($0.selectedImage, for: .normal)
                } else {
                    button.setImage($0.image, for: .normal)
                }
            }
        }
    }
}

// MARK: - TabBarViewControllerProtocol
extension TabBarViewController: TabBarViewControllerProtocol {
    
    func createTabBarControllers(controlelrs: [UIViewController]) {
        self.viewControllers = controlelrs
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.selectedViewController = viewController
        self.enableButton(by: tabBarController.selectedIndex)
        
        guard let type = TabBarButtonType(rawValue: tabBarController.selectedIndex) else { return }
        if let button = self.view.viewWithTag(tabBarController.selectedIndex + 100) as? UIButton {
            button.setImage(type.selectedImage, for: .normal)
        }
    }
}
