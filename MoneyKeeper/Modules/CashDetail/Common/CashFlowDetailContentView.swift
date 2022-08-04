//
//  CashFlowDetailContentView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZBarChart
import Business

// MARK: - CashFlowDetailContentViewDelegate
protocol CashFlowDetailContentViewDelegate: class {
    func updateModels(by period: PeriodType)
    func deleteModel(_ model: CashModel)
}

// MARK: - CashFlowDetailViewType
enum CashFlowDetailViewType: Int {
    case graphic = 0        //Show graphic
    case table = 1          //Show table
}

// MARK: - CashFlowDetailContentView
class CashFlowDetailContentView: UIView {

    //Properties
    private var periodView: PeriodsView!
    private var graphicView = CashFlowDetailGraphicView()
    private var collectionView = CashFlowDetailCollectionView()
    private var tableView = CashFlowDetailTableView()
    private var viewType: CashFlowDetailViewType = .graphic
    public weak var delegate: CashFlowDetailContentViewDelegate?

    //Init
    init() {
        self.periodView = PeriodsView(selectedPeriod: .week)
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.periodView = PeriodsView(selectedPeriod: .week)
        super.init(coder: aDecoder)
    }
    
    init(periodType: PeriodType) {
        self.periodView = PeriodsView(selectedPeriod: periodType)
        super.init(frame: .zero)
        self.createUI()
    }
}

// MARK: - Publics
extension CashFlowDetailContentView {
    
    public func displayGraphic(barModels: [YZBarViewModel], models: [CashModel], completion: @escaping () -> Void) {
        self.graphicView.displayBarViewModels(barModels)
        self.collectionView.displayModels(models)
        completion()
    }
    
    public func insertTable(models: [CashModel], completion: @escaping () -> Void) {
        self.tableView.insertModels(models) {
            completion()
        }
    }
    
    public func deleteTable(models: [CashModel], completion: @escaping () -> Void) {
        self.tableView.deleteModels(models, completion: completion)
    }

    
    public func updateStringLocalization() {
        self.periodView.updateStringLocalization()
        self.tableView.updateStringLocalization()
        self.collectionView.updateStringLocalization()
    }
}

// MARK: - Privates
extension CashFlowDetailContentView {
    
    private func createUI() {
        self.periodView.delegate = self
        self.addSubview(self.periodView)
        self.periodView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }

        self.addSubview(self.graphicView)
        self.graphicView.snp.makeConstraints {
            $0.top.equalTo(self.periodView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.graphicView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }

        self.tableView.delegate = self
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.periodView.snp.bottom)
            $0.left.equalTo(self.graphicView.snp.right)
            $0.width.equalTo(self.graphicView)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - CashFlowDetailTableDelegate
extension CashFlowDetailContentView: CashFlowDetailTableDelegate {
    
    func deleteModel(_ model: CashModel) {
        self.delegate?.deleteModel(model)
    }
}

// MARK: - PeriodsViewDelegate
extension CashFlowDetailContentView: PeriodsViewDelegate {
    
    func didSelectPeriod(_ period: PeriodType) {        
        let newViewType: CashFlowDetailViewType = (period == .all) ? .table : .graphic
        if newViewType == self.viewType {
            self.delegate?.updateModels(by: period)
        } else {
            self.viewType = newViewType
            
            let windowWidth = newViewType == .table ? -UIScreen.main.bounds.width : 0
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.2, animations: {
                self.graphicView.snp.updateConstraints({
                    $0.left.right.equalToSuperview().offset(windowWidth)
                })
                self.collectionView.snp.updateConstraints({
                    $0.left.right.equalToSuperview().offset(windowWidth)
                })
                self.layoutIfNeeded()
            }) { (completion) in
                if completion {
                    self.delegate?.updateModels(by: period)
                }
            }
        }
    }
}
