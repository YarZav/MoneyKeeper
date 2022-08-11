//
//  CashDetailPeriodType.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 8/10/22.
//

enum CashDetailPeriodType: Int, CaseIterable {

  case week   = 0         //one week
  case month  = 1         //ome month
  case year   = 2         //one year
  case all    = 3         //all period

  var title: String {
    switch self {
    case .week:
      return NSLocalizedString("Week", comment: "The name of the animal")
    case .month:
      return NSLocalizedString("Month", comment: "The name of the animal")
    case .year:
      return NSLocalizedString("Year", comment: "The name of the animal")
    case .all:
      return NSLocalizedString("AllTime", comment: "The name of the animal")
    }
  }

  var startDate: Date {
    let today = Date()
    var timeOffset = 0
      
    switch self {
    case .week:
      timeOffset = -6 * 24 * 60 * 60
    case .month:
      timeOffset = -29 * 24 * 60 * 60
    case .year:
      timeOffset = -364 * 24 * 60 * 60
    case .all:
      return Date(timeIntervalSince1970: 0)
    }

    let timeInterval = TimeInterval(timeOffset)
    return today.addingTimeInterval(timeInterval)
  }

  var endDate: Date {
    Date()
  }

}
