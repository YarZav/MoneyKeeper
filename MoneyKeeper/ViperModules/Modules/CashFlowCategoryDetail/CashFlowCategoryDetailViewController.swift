//
//  CashFlowCategoryDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowCategoryDetailViewController
class CashFlowCategoryDetailViewController: BaseViewController {
    
    // Properties
    public var presenter: CashFlowCategoryDetailPresenterProtocol!
    public var model: CashFlowModel!
    private var detailView: CashFlowCategoryDetailView!
    private var blurBackground: UIVisualEffectView!
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
}

// MAKR: - Publics
extension CashFlowCategoryDetailViewController {
    
    //FIXME: It need to create in constant
    public func dismissAnimateStart() {
        self.detailView.alpha = 0
    }
    
    //FIXME: It need to create in constant
    public func presentAnimate() {
        self.blurBackground.alpha = 0.75
    }
    
    //FIXME: It need to create in constant
    public func dismissAnimate() {
        self.blurBackground.alpha = 0
    }
    
    //FIXME: It need to create in constant
    public func presentAnimateCompletion() {
        self.detailView.alpha = 1
    }
}

// MARK: - Privates
extension CashFlowCategoryDetailViewController {
    
    func createUI() {
        self.view.backgroundColor = .clear
        
        let blurDarkEffect = UIBlurEffect(style: .dark)
        self.blurBackground = UIVisualEffectView(effect: blurDarkEffect)
        self.blurBackground.alpha = 0
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.detailView = CashFlowCategoryDetailView(model: self.model, transition: false)
        self.detailView.alpha = 0
        
        self.view.insertSubview(self.blurBackground, at: 0)
        self.view.addSubview(self.detailView)
        
        self.blurBackground.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func viewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - CashFlowCategoryDetailViewControllerProtocol
extension CashFlowCategoryDetailViewController: CashFlowCategoryDetailViewControllerProtocol { }
