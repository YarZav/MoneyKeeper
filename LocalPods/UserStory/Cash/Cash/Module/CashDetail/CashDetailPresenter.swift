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
  case year
}

final class CashDetailPresenter {

  // MARK: - Private property

  private let interactor: CashDetailInteractorProtocol
  private var cashModels = [CashModel]()

  // MARK: - Internal property

  weak var view: CashDetailViewProtocol?

  // MARK: - Init

  init(interactor: CashDetailInteractorProtocol) {
    self.interactor = interactor
  }

}

// MARK: - CashDetailPresenterProtocol

extension CashDetailPresenter: CashDetailPresenterProtocol {

  func viewDidLoad(by period: CashDetailPeriodType, type: CashType) {
    cashModels = interactor.getCashFlowDetails(type: type)
    prepareForDisplay(by: period, type: type)
  }

  func prepareForDisplay(by period: CashDetailPeriodType, type: CashType) {
    let startDate = period.startDate
    let endDate = period.endDate
    let periodCashModels = filterModels(cashModels, startDate: startDate, endDate: endDate)
    let typeCashModels = periodCashModels.filter { $0.type == type }

    if typeCashModels.isEmpty {
        view?.showNoContentView()
    } else {
      displayGraphicContent(models: cashModels, period: period)
    }
  }

}

// MARK: - Private

private extension CashDetailPresenter {

  func getBarModels(_ models: [CashModel], dates: [Date], type: CalculateBarModels, callback: @escaping ([YZBarModel]) -> Void) {
    let queue = DispatchQueue(label: "com.MoneyKeeper.getBarModels", qos: .userInteractive)
    queue.sync {
      DispatchQueue.main.async { [weak self] in
        switch type {
        case .day:
          let models = self?.getModelsByDay(models, dates: dates) ?? []
          callback(models)
        case .month:
          let models = self?.getModelsByMonth(models, dates: dates) ?? []
          callback(models)
        case .year:
          let models = self?.getModelsByYear(models, dates: dates) ?? []
          callback(models)
        }
      }
    }
  }

  func getModelsByDay(_ models: [CashModel], dates: [Date]) -> [YZBarModel] {
    var barModels = [YZBarModel]()

    for (dateIndex, date) in dates.enumerated() {
      let startOfDate = date.startOfDay
      let endOfDate = date.endOfDay

      var sumCash = Decimal(0)
      let dateString = date.asString(dateFormat: "dd")
      
      let filteredModelsByDay = filterModels(models, startDate: startOfDate, endDate: endOfDate)
      for filteredModelByDay in filteredModelsByDay {
          sumCash += filteredModelByDay.price
      }

      let barModel = YZBarModel(x: Decimal(dateIndex), y: sumCash, descriptionX: dateString)
      barModels.append(barModel)
    }

    return barModels
  }

  func getModelsByMonth(_ models: [CashModel], dates: [Date]) -> [YZBarModel] {
    var barModels = [YZBarModel]()

    for (dateIndex, date) in dates.enumerated() {
      let startOfDate = date.startOfMonth
      let endOfDate = date.endOfMonth
      let datesByDay = Date.dates(from: startOfDate, to: endOfDate, component: .day)

      var sumCash = Decimal(0)
      let dateString = date.asString(dateFormat: "LLL")

      let modelsByMonth = getModelsByDay(models, dates: datesByDay)
      modelsByMonth.forEach { sumCash += $0.y }

      let barModel = YZBarModel(x: Decimal(dateIndex), y: sumCash, descriptionX: dateString)
      barModels.append(barModel)
    }

    return barModels
  }

  func getModelsByYear(_ models: [CashModel], dates: [Date]) -> [YZBarModel] {
    var barModels = [YZBarModel]()

    for (dateIndex, date) in dates.enumerated() {
      let startOfDate = date.startOfMonth
      let endOfDate = date.endOfMonth
      let datesByDay = Date.dates(from: startOfDate, to: endOfDate, component: .day)

      var sumCash = Decimal(0)
      let dateString = date.asString(dateFormat: "YYYY")

      let modelsByYear = getModelsByMonth(models, dates: datesByDay)
      modelsByYear.forEach { sumCash += $0.y }

      let barModel = YZBarModel(x: Decimal(dateIndex), y: sumCash, descriptionX: dateString)
      barModels.append(barModel)
    }

    return barModels
  }

  func filterModels(_ models: [CashModel], startDate: Date, endDate: Date) -> [CashModel] {
    models.filter { $0.date.isBetween(date: startDate, andDate: endDate) }
  }

  func getBarConfig() -> YZBarConfiguration {
    var config = YZBarConfiguration()
    config.separateColor = .blueGray
    config.descriptionBarTextColor = .white
    config.barTouchColor = .white
    config.descriptionBarTextFont = UIFont.systemFont(ofSize: 8)
    return config
  }

  func displayGraphicContent(models: [CashModel], period: CashDetailPeriodType) {
    let filteredModels = filterModels(models, startDate: period.startDate, endDate: period.endDate)
    let barConfig = getBarConfig()

    let displayCodeBlock: (([CashModel], [YZBarModel]) -> Void) = { [weak self] (models, barModels) in
      let viewModels = barModels.compactMap({ YZBarViewModel(config: barConfig, model: $0) })
      self?.view?.showContentView()
      self?.view?.displayGraphic(models: models, barModels: viewModels)
      self?.view?.insertTable(models: models)
    }

    switch period {
    case .week, .month:
      let dates = Date.dates(from: period.startDate, to: Date(), component: .day)
      getBarModels(filteredModels, dates: dates, type: .day) { (barModels) in
        displayCodeBlock(models, barModels)
      }
    case .year:
      let dates = Date.dates(from: period.startDate.endOfMonth, to: Date().endOfMonth, component: .month)
      getBarModels(models, dates: dates, type: .month) { (barModels) in
        displayCodeBlock(models, barModels)
      }
    case .all:
      let sortedModels = cashModels.sorted { $0.date < $1.date }
      let fromDate = sortedModels.first?.date ?? Date()
      let toDate = sortedModels.last?.date ?? Date()
      let dates = Date.dates(from: fromDate, to: toDate, component: .year)
      getBarModels(models, dates: dates, type: .year) { (barModels) in
        displayCodeBlock(models, barModels)
      }
    }
  }

  func displayTableContent(models: [CashModel]) {
    view?.showContentView()
    view?.insertTable(models: models)
  }

}
