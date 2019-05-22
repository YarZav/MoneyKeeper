//
//  CashFlowDetailContentView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailContentViewDelegate
protocol CashFlowDetailContentViewDelegate: class {
    func updateModels(by period: PeriodType)
    func deleteModel(_ model: CashFlowModel)
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
    private var graphicView: CashFlowDetailGraphicView!
    private var tableView: CashFlowDetailTableView!
    private var viewType: CashFlowDetailViewType = .graphic
    public weak var delegate: CashFlowDetailContentViewDelegate?

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowDetailContentView {
    
    public func displayBarViewModels(_ models: [BarViewModel]) {
        switch self.viewType {
        case .graphic:
            self.graphicView.displayBarViewModels(models)
            
        case .table:
            break
        }
    }
    
    public func displayModels(_ models: [CashFlowModel]) {
        switch self.viewType {
        case .graphic:
            self.graphicView.displayModels(models)
            
        case .table:
            self.tableView.displayModels(models)
        }
    }
}

// MARK: - Privates
extension CashFlowDetailContentView {
    
    private func createUI() {
        self.periodView = PeriodsView(selectedPeriod: .week)
        self.periodView.delegate = self
        self.addSubview(self.periodView)
        self.periodView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(44)
        }

        self.graphicView = CashFlowDetailGraphicView()
        self.addSubview(self.graphicView)
        self.graphicView.snp.makeConstraints {
            $0.top.equalTo(self.periodView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        self.tableView = CashFlowDetailTableView()
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
    
    func deleteModel(_ model: CashFlowModel) {
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
            
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.2, animations: {
                self.graphicView.snp.updateConstraints({
                    let windowWidth = UIScreen.main.bounds.width
                    if newViewType == .table {
                        $0.left.equalToSuperview().offset(-windowWidth)
                        $0.right.equalToSuperview().offset(-windowWidth)
                    } else {
                        $0.left.equalToSuperview()
                        $0.right.equalToSuperview()
                    }
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
