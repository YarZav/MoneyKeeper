//
//  CashDetailTableSection.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 8/10/22.
//

import Business

final class CashDetailTableSection {

  // MARK: - Internal proeprty

  let date: Date
  var models = [CashModel]()

  // MARK: - Init

  init(date: Date, models: [CashModel]) {
    self.date = date
    self.models = models
  }

}
