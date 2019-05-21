//
//  CashFlowDetailPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowDetailPresenter
class CashFlowDetailPresenter: BasePresenter {
    
    //Properties
    private weak var view: CashFlowDetailViewControllerProtocol?
    private let interactor: CashFlowDetailInteractorProtocol
    private let wireFrame: CashFlowDetailWireFrameProtocol
    
    //Init
    init(view: CashFlowDetailViewControllerProtocol, interactor: CashFlowDetailInteractorProtocol, wireFrame: CashFlowDetailWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CashFlowDetailPresenterProtocol
extension CashFlowDetailPresenter: CashFlowDetailPresenterProtocol {
    
    func updateModels(by period: PeriodType) {
        let models = self.interactor.getCashFlowDetails()
        let filteredModels = self.filterModels(models, startDate: period.startDate, endDate: period.endDate)
        
        if filteredModels.isEmpty {
            self.createNoContent()
        } else {
            self.createContentView(models: filteredModels, period: period)
        }
    }
    
    func deleteModel(_ model: CashFlowModel) {
        self.interactor.deleteModel(model)
        
        let models = self.interactor.getCashFlowDetails()
        if models.isEmpty {
            self.createNoContent()
        }
    }
}

// MARK: - Privates
extension CashFlowDetailPresenter {
    
    private func getViewModelsByDay(_ models: [CashFlowModel], dates: [Date]) -> [BarViewModel] {
        var viewModels = [BarViewModel]()
        
        for date in dates {
            let startOfDate = date.startOfDay
            let endOfDate = date.endOfDay

            var sumCash: Double = 0.0
            let dateString = date.asString(dateFormat: "dd")
            
            let filteredModelsByDay = self.filterModels(models, startDate: startOfDate, endDate: endOfDate)
            for filteredModelByDay in filteredModelsByDay {
                sumCash += filteredModelByDay.price.doubleValue
            }
            
            let viewModel = BarViewModel(x: dateString, y: sumCash)
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
    
    private func getViewModelsByMonth(_ models: [CashFlowModel], dates: [Date]) -> [BarViewModel] {
        var viewModels = [BarViewModel]()

        for date in dates {
            let startOfDate = date.startOfMonth
            let endOfDate = date.endOfMonth
            let datesByDay = Date.dates(from: startOfDate, to: endOfDate, component: .day)
            
            var sumCash: Double = 0.0
            let dateString = date.asString(dateFormat: "LLL")
            
            let viewModelsByMonth = self.getViewModelsByDay(models, dates: datesByDay)
            viewModelsByMonth.forEach {
                sumCash += $0.y
            }

            let viewModel = BarViewModel(x: dateString, y: sumCash)
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
    
    private func filterModels(_ models: [CashFlowModel], startDate: Date, endDate: Date) -> [CashFlowModel] {
        let filteredModels = models.filter { $0.date.isBetween(date: startDate, andDate: endDate) }
        return filteredModels
    }
    
    private func createNoContent() {
        self.view?.createNoContentView()
    }
    
    private func createContentView(models: [CashFlowModel], period: PeriodType) {
        let filteredModels = self.filterModels(models, startDate: period.startDate, endDate: period.endDate)
        
        let viewModels: [BarViewModel]
        switch period {
        case .week, .month:
            let dates = Date.dates(from: period.startDate, to: Date(), component: .day)
            viewModels = self.getViewModelsByDay(filteredModels, dates: dates)
            
        case .year:
            let dates = Date.dates(from: period.startDate.endOfMonth, to: Date().endOfMonth, component: .month)
            viewModels = self.getViewModelsByMonth(filteredModels, dates: dates)
            
        case .all:
            viewModels = []
        }
        
        self.view?.createContentView()
        self.view?.displayContent(models: models, barModels: viewModels)
    }
}
