//
//  CashFlowDetailPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import YZBarChart
import Business

enum CalculateBarModels {
    case day
    case month
}

// MARK: - CashFlowDetailPresenter
class CashFlowDetailPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowDetailViewControllerProtocol?
    private let interactor: CashFlowDetailInteractorProtocol
    private let wireFrame: CashFlowDetailWireFrameProtocol
    
    private var cashFlowModels = [CashModel]()
    
    //Init
    init(view: CashFlowDetailViewControllerProtocol, interactor: CashFlowDetailInteractorProtocol, wireFrame: CashFlowDetailWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    override func languageChanged() {
        self.view?.updateStringLocalization()
    }
}

// MARK: - CashFlowDetailPresenterProtocol
extension CashFlowDetailPresenter: CashFlowDetailPresenterProtocol {
    
    func viewDidLoad(by period: PeriodType, type: CashType) {
        self.cashFlowModels = self.interactor.getCashFlowDetails(type: type)

        self.updateModels(by: period, type: type)
    }
    
    func updateModels(by period: PeriodType, type: CashType) {
        let filteredModels = self.filterModels(self.cashFlowModels, startDate: period.startDate, endDate: period.endDate).filter { $0.type == type }
        
        if filteredModels.isEmpty {
            self.view?.createNoContentView()
        } else {
            if period == .all {
                self.displayTableContent(models: self.cashFlowModels)
            } else {
                self.displayGraphicContent(models: self.cashFlowModels, period: period)
            }
        }
    }
    
    func deleteModel(_ model: CashModel, period: PeriodType, type: CashType) {
//        self.interactor.deleteModel(model) { (error) in
//            Thread.current.doInMainThread {
//                if let error = error {
//                    self.view?.showOkAlertController(title: "CashFlowCategoryDetailWarning".localized(), message: error.localizedDescription, handler: { })
//                } else {
//                    self.cashFlowModels.removeAll(where: { $0.id == model.id })
//                    self.updateModels(by: period, type: type)
//                }
//            }
//        }
    }
    
    func insertModel(_ model: CashModel, periodType: PeriodType, type: CashType) {
        Thread.current.doInMainThread {
            self.cashFlowModels.append(model)
            self.updateModels(by: periodType, type: type)
        }
    }
}

// MARK: - Privates
extension CashFlowDetailPresenter {
    
    /// Queue to calculate bar models
    private func getBarModels(_ models: [CashModel], dates: [Date], type: CalculateBarModels, callback: @escaping ([YZBarModel]) -> Void) {
        let queue = DispatchQueue(label: "com.MoneyKeeper.getBarModels", qos: .userInteractive)
        queue.sync {
            Thread.current.doInMainThread {
                switch type {
                case .day: callback(self.getModelsByDay(models, dates: dates))
                case .month: callback(self.getModelsByMonth(models, dates: dates))
                }
            }
        }
    }
    
    /// Get day models
    private func getModelsByDay(_ models: [CashModel], dates: [Date]) -> [YZBarModel] {
        var barModels = [YZBarModel]()
        
        for (dateIndex, date) in dates.enumerated() {
            let startOfDate = date.startOfDay
            let endOfDate = date.endOfDay

            var sumCash = Decimal(0)
            let dateString = date.asString(dateFormat: "dd")
            
            let filteredModelsByDay = self.filterModels(models, startDate: startOfDate, endDate: endOfDate)
            for filteredModelByDay in filteredModelsByDay {
                sumCash += filteredModelByDay.price
            }
            
            let barModel = YZBarModel(x: Decimal(dateIndex), y: sumCash, descriptionX: dateString)
            barModels.append(barModel)
        }
        
        return barModels
    }
    
    /// Get month models
    private func getModelsByMonth(_ models: [CashModel], dates: [Date]) -> [YZBarModel] {
        var barModels = [YZBarModel]()

        for (dateIndex, date) in dates.enumerated() {
            let startOfDate = date.startOfMonth
            let endOfDate = date.endOfMonth
            let datesByDay = Date.dates(from: startOfDate, to: endOfDate, component: .day)
            
            var sumCash = Decimal(0)
            let dateString = date.asString(dateFormat: "LLL")
            
            let modelsByMonth = self.getModelsByDay(models, dates: datesByDay)
            modelsByMonth.forEach {
                sumCash += $0.y
            }

            let barModel = YZBarModel(x: Decimal(dateIndex), y: sumCash, descriptionX: dateString)
            barModels.append(barModel)
        }
        
        return barModels
    }
    
    /// Filter cash flow models by dates
    private func filterModels(_ models: [CashModel], startDate: Date, endDate: Date) -> [CashModel] {
        let filteredModels = models.filter { $0.date.isBetween(date: startDate, andDate: endDate) }
        return filteredModels
    }
    
    /// Get bar config
    private func getBarConfig() -> YZBarConfiguration {
        var config = YZBarConfiguration()
        config.separateColor = .blueGray
        config.descriptionBarTextColor = .white
        config.barTouchColor = .white
        config.descriptionBarTextFont = UIFont.systemFont(ofSize: 8)
        return config
    }
    
    /// Prepare and display bar models
    private func displayGraphicContent(models: [CashModel], period: PeriodType) {
        let filteredModels = self.filterModels(models, startDate: period.startDate, endDate: period.endDate)
        let barConfig = self.getBarConfig()
        
        let displayCodeBlock: (([CashModel], [YZBarModel]) -> Void) = { (models, barModels) in
            let viewModels = barModels.compactMap({ YZBarViewModel(config: barConfig, model: $0) })
            self.view?.createContentView()
            self.view?.displayGraphic(models: models, barModels: viewModels)
        }
        
        switch period {
        case .week, .month:
            let dates = Date.dates(from: period.startDate, to: Date(), component: .day)
            self.getBarModels(filteredModels, dates: dates, type: .day) { (barModels) in
                displayCodeBlock(models, barModels)
            }
            
        case .year:
            let dates = Date.dates(from: period.startDate.endOfMonth, to: Date().endOfMonth, component: .month)
            self.getBarModels(models, dates: dates, type: .month) { (barModels) in
                displayCodeBlock(models, barModels)
            }
            
        case .all:
            break
        }
    }
    
    /// Present table content
    private func displayTableContent(models: [CashModel]) {
        self.view?.createContentView()
        self.view?.insertTable(models: models)
    }
}
