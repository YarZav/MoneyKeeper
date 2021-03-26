//
//  SwinjectAssembly.swift
//  MoneyKeeper
//
//  Created by y.zavyalov on 26.03.2021.
//

import Swinject

// MARK: - SwinjectAssembly
final class SwinjectAssembly {
  /// Swinject Assembler
  var assembler: Assembler

  /// If you want use custom Assembler
  init(with assemblies: [Assembly]) {
    assembler = Assembler(assemblies)
  }

  /// All Assembly
  class var assembler: Assembler {
    let assembler = Assembler()
    assembler.apply(assemblies: moduleAssembly)
    return assembler
  }
}

// MARK: - Module
extension SwinjectAssembly {
  class var moduleAssembly: [Assembly] {
    return [
      TabBarAssembly()
    ]
  }
}

