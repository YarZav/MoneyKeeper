//
//  Date+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 04.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public extension Date {
    
  /// Get string from date base on formatter, "HH:mm" "dd.MM.yy" etc
  ///
  /// - Parameters:
  ///     - dateFormat: format for date, i.e. "dd.MM.yy"
  func asString(dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    if let identifier = Locale.preferredLanguages.first {
      dateFormatter.locale = Locale(identifier: identifier)
    }
    return dateFormatter.string(from: self)
  }
  
  /// Is date between two days
  ///
  /// - Parameters:
  ///     - date1: start date
  ///     - date2: end date
  func isBetween(date date1: Date, andDate date2: Date) -> Bool {
    date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
  }
  
  ///Get all dates between two dates
  static func dates(from fromDate: Date, to toDate: Date, component: Calendar.Component) -> [Date] {
    var dates: [Date] = []
    var date = fromDate

    while date <= toDate {
      dates.append(date)
      guard let newDate = Calendar.current.date(byAdding: component, value: 1, to: date) else { break }
      date = newDate
    }

    return dates
  }
  
  /// Get start of day with 00:00:00
  var startOfDay: Date {
    Calendar.current.startOfDay(for: self)
  }
  
  /// Get end of day with 23:59:59
  var endOfDay: Date {
    var components = DateComponents()
    components.day = 1
    components.second = -1
    return Calendar.current.date(byAdding: components, to: self.startOfDay)!
  }
  
  /// Get start day in month
  var startOfMonth: Date {
    let components = Calendar.current.dateComponents([.year, .month], from: self.startOfDay)
    return Calendar.current.date(from: components)!
  }
  
  /// Get end day of month
  var endOfMonth: Date {
    var components = DateComponents()
    components.month = 1
    components.second = -1
    return Calendar.current.date(byAdding: components, to: self.startOfMonth)!
  }
}
