//
//  CardScannerViewController.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

// MARK: - CardScannerViewController
class CardScannerViewController: BaseViewController {
    
    //Properties
    public var presenter: CardScannerPresenterProtocol!
    private var scannerViewController: BaseScannerViewConroller!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - CardScannerViewControllerProtocol
extension CardScannerViewController: CardScannerViewControllerProtocol { }

// MARK: - Privates
extension CardScannerViewController {
    
    private func createUI() {
        self.view.backgroundColor = .black
        
        self.scannerViewController = BaseScannerViewConroller()
        self.scannerViewController.delegate = self
        self.addChild(self.scannerViewController)
        self.view.addSubview(self.scannerViewController.view)
        self.scannerViewController.view.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - BaseScannerDelegate
extension CardScannerViewController: BaseScannerDelegate {
    
    func scanHelpDescription() -> String? {
        return "CardScanScanHelp".localized()
    }
    
    func prefersStatusBarHidden(_ scannerViewController: BaseScannerViewConroller) -> Bool {
        return true
    }
    
    func supportedInterfaceOrientations(_ scannerViewController: BaseScannerViewConroller) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    func metaDataObjectTypes(_ scannerViewController: BaseScannerViewConroller) -> [AVMetadataObject.ObjectType] {
        return [.ean8, .ean13, .dataMatrix]
    }
    
    func overlayBackgroundColor(_ scannerViewController: BaseScannerViewConroller) -> UIColor {
        return UIColor(white: (50.0 / 256.0), alpha: 0.75)
    }
    
    func scanRect(_ scannerViewController: BaseScannerViewConroller) -> CGRect {
//        let x = UIScreen.main.bounds.size.width / 10.0
//        let width = UIScreen.main.bounds.size.width - x * 2
//        let height = width / 3.0 * 2.0
//        let y = (UIScreen.main.bounds.size.height - self.getNavigationbarHeight() - height) / 2.0
//        return CGRect(x: x, y: y, width: width, height: height)
      return .zero
    }
    
    func scanFailed(_ scannerViewController: BaseScannerViewConroller) {
        let alertController = UIAlertController(title: "CardScanScanFailedTitle".localized(), message: "CardScanScanFailedMessage".localized(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "CardScanOk".localized(), style: .default))
        self.present(alertController, animated: true)
    }
    
    func scanSucced(_ scannerViewController: BaseScannerViewConroller, code: String, type: AVMetadataObject.ObjectType) {
        self.presenter.scanCode(code, type: type)
    }
}
