//
//  CashFlowDetailViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit


// MARK: - CashFlowDetailViewController
class CashFlowDetailViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowDetailPresenterProtocol!
    private var viewType: CashFlowType = .consumption
    
    private var noContentView: CashFlowDetailNoContentView?
    private var contentView: CashFlowDetailContentView?
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.updateModels(by: .week)
    }
}

// MARK: - CashFlowDetailViewControllerProtocol
extension CashFlowDetailViewController: CashFlowDetailViewControllerProtocol {
    
    func createNoContentView() {
        if let contentView = self.contentView {
            contentView.removeFromSuperview()
        }
        
        if self.noContentView == nil {
            let noContentView = CashFlowDetailNoContentView()
            self.noContentView = noContentView
            self.view.addSubview(noContentView)
            noContentView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
            }
        }
    
        self.view.layoutIfNeeded()
    }
    
    func createContentView() {
        if let noContentView = self.noContentView {
            noContentView.removeFromSuperview()
        }
        
        if self.contentView == nil {
            let contentView = CashFlowDetailContentView()
            contentView.delegate = self
            self.contentView = contentView
            self.view.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
    func displayContent(models: [CashFlowModel], barModels: [BarViewModel]) {
        self.contentView?.displayBarViewModels(barModels)
        self.contentView?.displayModels(models)
    }
}

// MARK: - Actions
extension CashFlowDetailViewController {
    
    @objc private func swipeViewTypeAction() {
        switch self.viewType {
        case .consumption:  self.viewType = .income
        case .income:       self.viewType = .consumption
        }
        
        self.navigationItem.title = self.viewType.title
        
        //FIXME: Get data and update UI
    }
}

// MARK: - Privates
extension CashFlowDetailViewController {
    
    private func createUI() {
        self.navigationItem.title = self.viewType.title
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
        self.presenter.deleteModel(model)
    }
    
    func updateModels(by period: PeriodType) {
        self.presenter.updateModels(by: period)
    }
}
