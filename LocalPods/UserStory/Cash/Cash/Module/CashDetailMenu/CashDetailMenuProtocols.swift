//
//  CashDetailMenuProtocols.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 10/30/22.
//

public protocol CashDetailMenuProtocol:  CashDetailMenuInputProtocol &  CashDetailMenuOutputProtocol { }

// INPUT
public protocol CashDetailMenuInputProtocol {

  var isOpened: Bool { get set }

}

// OUTPUT
public protocol CashDetailMenuOutputProtocol {

  var hide: (() -> Void)? { get set }

}

// PRESENTER -> VIEW
protocol CashDetailMenuViewProtocol: AnyObject { }
