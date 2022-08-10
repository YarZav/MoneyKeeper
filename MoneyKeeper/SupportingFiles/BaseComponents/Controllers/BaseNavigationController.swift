////
////  BaseNavigationController.swift
////  MoneyKeeper
////
////  Created by admin on 19.09.2018.
////  Copyright © 2018 ZYG. All rights reserved.
////
//
//import UIKit
//
//// MARK: - BaseNavigationController
//class BaseNavigationController: UINavigationController {
//
//    //Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.createUI()
//    }
//    
//    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if self.topViewController === viewController { return}
//        
//        super.pushViewController(viewController, animated: animated)
//        self.setLeftNavigationButton(for: viewController)
//    }
//}
//
//// MARK: - Publics
//extension BaseNavigationController {
//    
//    public func setLeftNavigationButton(for controller: UIViewController) {
//        guard let viewController = controller as? BaseViewController else { return }
//        let viewControllers = viewController.navigationController?.viewControllers ?? []
//        if viewControllers.count > 1 {
//            viewController.makeLeftBarButtonItem()
//        }
//    }
//}
//
//// MARK: - Prviates
//extension BaseNavigationController {
//    
//    private func createUI() {
//        self.interactivePopGestureRecognizer?.delegate = self
//        self.interactivePopGestureRecognizer?.isEnabled = true
//    }
//}
//
//// MARK: - UIGestureRecognizerDelegate
//extension BaseNavigationController: UIGestureRecognizerDelegate {
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
