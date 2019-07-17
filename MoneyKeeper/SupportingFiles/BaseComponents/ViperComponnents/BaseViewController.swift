//
//  BaseViewController.swift
//  MoneyKeeper
//
//  Created by admin on 19.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import SnapKit
import YZNotificationView

// MARK: - BaseViewControllerProtocol
protocol BaseViewControllerProtocol: class {
    func showOkAlertController(title: String?, message: String?, handler: @escaping () -> Void)
    func showNotificationView(title: String?, image: UIImage?)
}

// MARK: - BaseViewController
class BaseViewController: UIViewController {

    //Properties
    public var bottomOffset: CGFloat = 0
    public var keyboardShiftContraint = [Constraint]()
    public var keyboardScrollViewBottomInset: UIScrollView?
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.registerKeyboardNotifications()
    }
}

// MARK: - Navigation bar
extension BaseViewController {
    
    public func getNavigationbarHeight() -> CGFloat {
        let rect = self.navigationController?.navigationBar.frame
        let height = (rect?.size.height ?? 0) + (rect?.origin.y ?? 0)

        return height
    }
    
    public func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0;
    }
    
    public func setRightBarButtons(_ buttons: [UIBarButtonItem]) {
        self.navigationItem.setRightBarButtonItems(buttons, animated: false)
    }
    
    public func makeLeftBarButtonItem() {
        let image = UIImage(named: "BackWhite")?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.backAction))
        self.navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
    }
}

// MARK: - Actions
extension BaseViewController {
    
    @objc public func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Alerts
extension BaseViewController: BaseViewControllerProtocol {
    
    func showOkAlertController(title: String?, message: String?, handler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "BaseControllerOk".localized(), style: .default) { (_) in
            handler()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNotificationView(title: String?, image: UIImage?) {
        var config = YZNotificationViewConfig()
        config.imageViewBackgroundColor = .plainGray
        config.backgroundColor = .darkViolet
        config.textColor = .white
        config.textAlignment = .center
        config.textFont = UIFont.systemFont(ofSize: 21)

        let notificationManager = YZNotificationManager.sharedInstance
        let notification = YZNotificationView(text: title, image: image, position: .topPosition, configuration: config)
        notificationManager.showNotifiationView(notification)
    }
}

// MARK: - Keyboard
extension BaseViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(notification: Notification) {
        self.updateConstraints(notification: notification, isShown: true)
    }
    
    @objc private func keyBoardWillHide(notification: Notification) {
        self.updateConstraints(notification: notification, isShown: false)
    }
    
    private func updateConstraints(notification: Notification, isShown: Bool) {
        guard let (keyboardSize, animationCurve, animationDuration) = self.getKeyboardUserInfo(notification: notification) else {
            return
        }
        
        let offset = isShown ? (-keyboardSize.height - self.bottomOffset) : self.bottomOffset
        self.keyboardShiftContraint.forEach { (contraint) in
            contraint.update(offset: offset)
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        
        self.view.layoutIfNeeded()
        var insets = UIEdgeInsets.zero
        insets.bottom = insets.bottom + (isShown ? (keyboardSize.height - self.bottomOffset) : 0)
        self.keyboardScrollViewBottomInset?.contentInset = insets
        
        UIView.commitAnimations()
    }
    
    private func getKeyboardUserInfo(notification: Notification) -> (keyboardSize: CGRect, animationCurve: UIView.AnimationCurve, animationDuration: TimeInterval)? {
        guard let userInfo = notification.userInfo else {
            return nil
        }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return nil
        }
        
        guard let animationInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int, let animationCurve = UIView.AnimationCurve(rawValue: animationInt) else {
            return nil
        }
        
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return nil
        }
        
        return (keyboardSize, animationCurve, animationDuration)
    }
}
