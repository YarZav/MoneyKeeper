//
//  CashFlowCategoryDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// MARK: - Constaints and strings
private struct CashFlowCategoryDetailStruct {
    static let blurBackgroundAlphaToShow: CGFloat = 0.75
    static let hideAlphaView: CGFloat = 0
    static let showAlphaView: CGFloat = 1
}

// MARK: - CashFlowCategoryDetailViewController
class CashFlowCategoryDetailViewController: BaseViewController {
    
    // Properties
    public var presenter: CashFlowCategoryDetailPresenterProtocol!
//    public var model: CategoryModel!
    private var detailView: CashFlowCategoryDetailView!
    private var blurBackground: UIVisualEffectView!
    private var deleteButton = UIButton(type: .custom)
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
}

// MAKR: - Publics
extension CashFlowCategoryDetailViewController {
    
    public func dismissAnimateStart() {
        self.detailView.alpha = CashFlowCategoryDetailStruct.hideAlphaView
        self.removeDeleteButton()
    }
    
    public func presentAnimate() {
        self.blurBackground.alpha = CashFlowCategoryDetailStruct.blurBackgroundAlphaToShow
    }
    
    public func dismissAnimate() {
        self.blurBackground.alpha = CashFlowCategoryDetailStruct.hideAlphaView
    }
    
    public func presentAnimateCompletion() {
        self.detailView.alpha = CashFlowCategoryDetailStruct.showAlphaView
        self.createDeleteButton()
    }
}

// MARK: - Privates
extension CashFlowCategoryDetailViewController {
    
    private func createUI() {
        self.view.backgroundColor = .clear
        
        let blurDarkEffect = UIBlurEffect(style: .dark)
        self.blurBackground = UIVisualEffectView(effect: blurDarkEffect)
        self.blurBackground.alpha = CashFlowCategoryDetailStruct.hideAlphaView
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.view.addGestureRecognizer(tapRecognizer)
        
//        self.detailView = CashFlowCategoryDetailView(model: self.model, transition: false)
        self.detailView.alpha = CashFlowCategoryDetailStruct.hideAlphaView
        
        self.view.insertSubview(self.blurBackground, at: 0)
        self.view.addSubview(self.detailView)
        
        self.blurBackground.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createDeleteButton() {
        self.deleteButton.backgroundColor = .darkRed
        self.deleteButton.setTitle("CashFlowCategoryDetailDeleteCategory".localized(), for: .normal)
        self.deleteButton.titleLabel?.textColor = .white
        self.deleteButton.layer.cornerRadius = 8
        self.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        self.view.addSubview(self.deleteButton)
        self.deleteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
    }
    
    private func removeDeleteButton() {
        self.deleteButton.removeFromSuperview()
    }
}

// MARK: - Actions
extension CashFlowCategoryDetailViewController {
    
    @objc private func viewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func deleteAction() {
//        self.presenter.deleteCategoryModel(self.model)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - CashFlowCategoryDetailViewControllerProtocol
extension CashFlowCategoryDetailViewController: CashFlowCategoryDetailViewControllerProtocol { }
