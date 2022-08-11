//
//  SearchBar.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 8/8/22.
//

import UIKit

public protocol SearchBarDelegate: AnyObject {

  /// Search by new text
  func search(by text: String)

}

public final class SearchBar: UISearchBar {

  // MARK: - Constants

  private enum Constants {
    static let searchPlacehodler = "SearchPlacehodlerKey".localized()
  }

  // MARK: - Public property

  public weak var searchDelegate: SearchBarDelegate?

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    createUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Private

private extension SearchBar {

  func createUI() {
    sizeToFit()
    tintColor = .black
    delegate = self
    placeholder = Constants.searchPlacehodler
  }

}

// MARK: - UISearchBarDelegate

extension SearchBar: UISearchBarDelegate {

  public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }

  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchDelegate?.search(by: searchText)
  }

  public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }

}
