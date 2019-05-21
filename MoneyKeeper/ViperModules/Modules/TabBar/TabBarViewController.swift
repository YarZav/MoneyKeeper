//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarViewStruct
struct TabBarViewStruct {
    static let buttonCount: CGFloat = 5
    static let buttonWidth: CGFloat = UIScreen.main.bounds.size.width / TabBarViewStruct.buttonCount
}

// MARK: - TabBarButtonType
private enum TabBarButtonType: CaseIterable {
    case cashFlow
    case cashFlowDetail
    case cards
    case goals
    case settings
    
    var color: UIColor {
        switch self {
        case .cashFlow:         return .darkViolet
        case .cashFlowDetail:   return .plainGray
        case .cards:            return .blueGray
        case .goals:            return .plainPurple
        case .settings:         return .lightBlue
        }
    }
    
    var image: UIImage? {
        switch self {
        case .cashFlow:         return UIImage(named: "CashFlow")
        case .cashFlowDetail:   return UIImage(named: "CashFlowDetail")
        case .cards:            return UIImage(named: "Cards")
        case .goals:            return UIImage(named: "Goals")
        case .settings:         return UIImage(named: "Settings")
        }
    }
}

// MARK: - TabBarViewController
class TabBarViewController: BaseTabBarController {

    //Properties
    public var presenter: TabBarPresenterProtocol!

    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.addButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.createTabBarControlelrs()
    }
}

// MARK: - Privates
extension TabBarViewController {
    
    private func addButtons() {
        var previousButton: UIButton?
        TabBarButtonType.allCases.forEach { (barButtonType) in
            let image = barButtonType.image?.withRenderingMode(.alwaysOriginal)
            let tabBarButton = self.createTabBarButton(color: barButtonType.color, image: image)
            
            self.tabBar.addSubview(tabBarButton)
            self.tabBar.bringSubviewToFront(tabBarButton)
            
            tabBarButton.snp.makeConstraints {
                if let prevButton = previousButton {
                    $0.width.equalTo(prevButton.snp.width)
                    $0.left.equalTo(prevButton.snp.right)
                } else {
                    $0.left.equalToSuperview()
                }
                
                if barButtonType == TabBarButtonType.settings {
                    $0.right.equalToSuperview()
                }

                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            previousButton = tabBarButton
        }
    }
    
    private func createTabBarButton(color: UIColor, image: UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = color
        button.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        return button
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
    }
}
