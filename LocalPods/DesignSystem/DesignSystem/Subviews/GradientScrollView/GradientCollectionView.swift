//
//  GradientCollectionView.swift
//  DesignSystem
//
//  Created by Yaroslav Zavyalov on 8/20/22.
//

public final class GradientCollectionView: UICollectionView {
    
  // MARK: - Private property

  private var topEndGradientPoint: NSNumber = NSNumber(value: 0.0)
  private var bottomStartGradientPoint: NSNumber = NSNumber(value: 0.9)
  
  // MARK: - Init

  public init(
    cells: [AnyClass],
    dataSource: UICollectionViewDataSource? = nil,
    delegate: UICollectionViewDelegate? = nil
  ) {
    super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    self.dataSource = dataSource
    self.delegate = delegate
    cells.forEach { cellClass in
      guard let casted = cellClass.self as? UICollectionViewCell.Type else {
        fatalError("Cell is not inheritance from UIColelctionCell")
      }
      let reuseIdentifier = String(describing: casted.self)
      self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    updateGradient()
  }

}

// MARK: - Public

public extension GradientCollectionView {

  func setTopGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) {
    topEndGradientPoint = getTopGradientPoint(scrollView)
  }

  func setBottomGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) {
    bottomStartGradientPoint = getBottomGradientPoint(scrollView)
  }

  func reloadDataAndSetGradient() {
    UIView.animate(
      withDuration: 0,
      animations: {
        self.reloadData()
      }, completion: { [weak self] _ in
        guard let self = self else { return }
        self.setTopGradientPoint(self)
        self.setBottomGradientPoint(self)
      }
    )
  }

}

// MARK: - Prvate

private extension GradientCollectionView {

  func updateGradient() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
        UIColor(white: 1, alpha: 0).cgColor,
        UIColor(white: 1, alpha: 1).cgColor,
        UIColor(white: 1, alpha: 1).cgColor,
        UIColor(white: 1, alpha: 0).cgColor
    ]
    gradient.locations = [0, topEndGradientPoint, bottomStartGradientPoint, 1]
    layer.mask = gradient
  }

}

