//
//  SwinjectAssembly.swift
//  MoneyKeeper
//
//  Created by y.zavyalov on 26.03.2021.
//

import Swinject

public final class SwinjectAssembly {

  // MARK: - Public property

  public let assembler: Assembler

  // MARK: - Init

  public init(with assemblies: [Assembly]) {
    assembler = Assembler(assemblies)
  }

}

