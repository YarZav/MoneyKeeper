//
//  KeyboardManager.swift
//  Service
//
//  Created by Yaroslav Zavyalov on 8/21/22.
//

public protocol KeyboardManagerProtocol {

  /// Keyboard height
  var keyboardSize: CGRect { get }

  /// Bottom offset when keyboard is inactive
  var bottomOffset: CGFloat { get set }

  /// Bottom offset when keyboard is active (Between keyboard and view)
  var keyboardOffset: CGFloat { get set }

  /// Constraints which depends on keyboard
  var keyboardShiftConstraints: [NSLayoutConstraint] { get set }

  /// Code block when keyboard animated/showed
  var keyboardShiftConstraintsBlock: ((Bool) -> Void)? { get set }

}

public final class KeyboardManager: KeyboardManagerProtocol {

  // MARK: - Public property

  /// Keyboard height
  public var keyboardSize: CGRect = .zero

  /// Bottom offset when keyboard is inactive
  public var bottomOffset: CGFloat = 0

  /// Bottom offset when keyboard is active (Between keyboard and view)
  public var keyboardOffset: CGFloat = 0

  /// Constraints which depends on keyboard
  public var keyboardShiftConstraints: [NSLayoutConstraint] = []

  /// Code block when keyboard animated/showed
  public var keyboardShiftConstraintsBlock: ((Bool) -> Void)?

  // MARK: - Init

  public init() {
    addObservers()
  }

}

// MARK: - Observer

private extension KeyboardManager {

  func addObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self,
      selector: #selector(keyBoardWillShow(notification:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )

    notificationCenter.addObserver(
      self,
      selector: #selector(keyBoardWillHide(notification:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
}

// MARK: - Action

private extension KeyboardManager {

  @objc
  func keyBoardWillShow(notification: Notification) {
    updateConstraints(notification, isShown: true)
  }

  @objc
  func keyBoardWillHide(notification: Notification) {
    updateConstraints(notification, isShown: false)
  }
}

// MARK: - Private

private extension KeyboardManager {

  func updateConstraints(_ notification: Notification, isShown: Bool) {
    guard
      let keyboardSize = getKeyboardSize(notification),
      let animationCurve = getKeyboardAnimationCurve(notification),
      let animationDuration = getKeyboardAnimationDuration(notification)
    else { return }

    self.keyboardSize = keyboardSize
    let offset = isShown ? (-keyboardSize.height - keyboardOffset) : bottomOffset
    keyboardShiftConstraints.forEach { $0.constant = offset }
    keyboardShiftConstraintsBlock?(isShown)

    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(animationDuration)
    UIView.setAnimationCurve(animationCurve)

//    view.layoutIfNeeded()
    var insets = UIEdgeInsets.zero
    insets.bottom += isShown ? (keyboardSize.height - keyboardOffset) : bottomOffset

    UIView.commitAnimations()
  }

  func getKeyboardSize(_ notification: Notification) -> CGRect? {
    guard
      let userInfo = notification.userInfo,
      let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    else { return nil }

    return keyboardSize
  }

  func getKeyboardAnimationCurve(_ notification: Notification) -> UIView.AnimationCurve? {
    guard
      let userInfo = notification.userInfo,
      let animationInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
      let animationCurve = UIView.AnimationCurve(rawValue: animationInt)
    else { return nil }

    return animationCurve
  }

  func getKeyboardAnimationDuration(_ notification: Notification) -> TimeInterval? {
    guard
      let userInfo = notification.userInfo,
      let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    else { return nil }

    return animationDuration
  }

}

