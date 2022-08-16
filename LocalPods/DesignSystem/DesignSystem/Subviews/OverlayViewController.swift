//
//  OverlayViewController.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 8/6/22.
//

import OverlayContainer

public final class OverlayViewController: OverlayContainerViewController {

  // MARK: - Constants

  private enum Constants {
    static let showAlpha: CGFloat = 0.7
  }

  // MARK: - Private property

  /// Dark view
  private var darkView = UIView()

  // MARK: - Life circle

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    createUI()
    showDarkView()
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    hideAction()
  }

}

// MARK: - Privates

private extension OverlayViewController {
  func createUI() {
    addDarkView()
    addHideButton()
  }

  func addHideButton() {
    let hideButton = UIButton(type: .custom)
    hideButton.addTarget(self, action: #selector(hideAction), for: .touchUpInside)

    darkView.addSubview(hideButton)
    hideButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hideButton.leftAnchor.constraint(equalTo: darkView.leftAnchor),
      hideButton.rightAnchor.constraint(equalTo: darkView.rightAnchor),
      hideButton.topAnchor.constraint(equalTo: darkView.topAnchor),
      hideButton.bottomAnchor.constraint(equalTo: darkView.bottomAnchor)
    ])
  }

  /// Add out dark view
  func addDarkView() {
    guard let parent = self.parent else {
      fatalError("Parent view for dark is nil")
    }

    parent.navigationController?.navigationBar.layer.zPosition = -1

    let navigationBarheight = parent.navigationController?.navigationBar.frame.height ?? 0.0
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let topOffset = navigationBarheight + statusBarHeight

    darkView.backgroundColor = .black
    darkView.alpha = 0.0

    parent.view.addSubview(darkView)
    darkView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      darkView.leftAnchor.constraint(equalTo: parent.view.leftAnchor),
      darkView.rightAnchor.constraint(equalTo: parent.view.rightAnchor),
      darkView.topAnchor.constraint(equalTo: parent.view.topAnchor, constant: -topOffset),
      darkView.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor)
    ])
  }

  /// Show dark view with animation
  func showDarkView() {
      UIView.animate(withDuration: DesignConstants.Time.plainDuration) {
      let frame = self.view.frame
      self.view.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
      self.darkView.alpha = Constants.showAlpha
    }
  }

}

// MARK: - Publics
public extension OverlayViewController {

  /// Hide view controller
  func hide(animated: Bool, completion: (() -> Void)?) {
      UIView.animate(withDuration: animated ? DesignConstants.Time.plainDuration : 0.0, animations: {
      self.darkView.alpha = 0.0
      let bound = self.view.bounds
      self.view.frame = CGRect(x: 0, y: bound.height, width: bound.width, height: bound.height)
    }, completion: { [weak self] _ in
      self?.darkView.removeFromSuperview()

      self?.parent?.navigationController?.navigationBar.isUserInteractionEnabled = true
      self?.parent?.navigationController?.navigationBar.layer.zPosition = 0

      self?.children.forEach { $0.removeFromParent() }

      self?.willMove(toParent: nil)
      self?.view.removeFromSuperview()
      self?.removeFromParent()
      completion?()
    })
  }

}

// MARK: - Actions
private extension OverlayViewController {

  @objc
  func hideAction() {
    hide(animated: true, completion: nil)
  }

}
