//
//  CashFlowDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZBarChart

// MARK: - CashFlowDetailViewController
class CashFlowDetailViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowDetailPresenterProtocol!
    private var periodType: PeriodType = .week
    private var viewType: CashFlowType = .outcome
    
    private var noContentView = LabelView()
    private var contentView: CashFlowDetailContentView?
        
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad(by: self.periodType, type: self.viewType)
    }
}

// MARK: - CashFlowDetailViewControllerProtocol
extension CashFlowDetailViewController: CashFlowDetailViewControllerProtocol {
    
    func updateStringLocalization() {
        self.navigationItem.title = self.viewType.title.localized()
        self.noContentView.display("CashFlowCategoryDetailCanDisplayCashFlow".localized())
        self.contentView?.updateStringLocalization()
    }
    
    func createNoContentView() {
        if let contentView = self.contentView, self.view.subviews.contains(contentView) {
            contentView.removeFromSuperview()
        }
        
        if !self.view.subviews.contains(self.noContentView) {
            self.view.addSubview(self.noContentView)
            self.noContentView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
            }
        }
        self.noContentView.display("CashFlowCategoryDetailCanDisplayCashFlow".localized())
    }
    
    func createContentView() {
        if self.view.subviews.contains(self.noContentView) {
            self.noContentView.removeFromSuperview()
        }
        
        if self.contentView == nil {
            self.contentView = CashFlowDetailContentView(periodType: self.periodType)
            self.contentView?.delegate = self
        }
        
        if let contentView = self.contentView, !self.view.subviews.contains(contentView) {
            self.view.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
            }
        }
    }
    
    func displayGraphic(models: [CashFlowModel], barModels: [YZBarViewModel]) {
        self.contentView?.displayGraphic(barModels: barModels, models: models, completion: {
            //FIXME: USe it
        })
    }
    
    func insertTable(models: [CashFlowModel]) {
        self.contentView?.insertTable(models: models, completion: {
            //FIXME: Use it
        })
    }
    
    func deleteTable(models: [CashFlowModel]) {
        self.contentView?.deleteTable(models: models, completion: {
            //FIXME: Use it
        })
    }
}

// MARK: - Actions
extension CashFlowDetailViewController {
    
    @objc private func swipeViewTypeAction() {
        switch self.viewType {
        case .outcome:
            self.viewType = .income
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGreen]

        case .income:
            self.viewType = .outcome
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkRed]
        }
        
        self.navigationItem.title = self.viewType.title.localized()
        self.presenter.updateModels(by: self.periodType, type: self.viewType)
    }
}

// MARK: - Privates
extension CashFlowDetailViewController {
    
    private func createUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkRed]
        self.navigationItem.title = self.viewType.title.localized()
        self.view.backgroundColor = .darkViolet
        
        let image = UIImage(named: "SwipeType")?.withRenderingMode(.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(swipeViewTypeAction))
        rightBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0);
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - CashFlowDetailGraphicDelegate
extension CashFlowDetailViewController: CashFlowDetailContentViewDelegate {
    
    func deleteModel(_ model: CashFlowModel) {
        self.presenter.deleteModel(model, period: self.periodType, type: self.viewType)
    }
    
    func updateModels(by period: PeriodType) {
        self.periodType = period
        self.presenter.updateModels(by: self.periodType, type: self.viewType)
    }
}
