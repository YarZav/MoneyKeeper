//
//  UIImage+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 21.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public extension UIImage {

  /// Color image with color
  ///
  /// - Parameters:
  ///     - color: redraw image with color
  class func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }

  /// Resize image (dimension this is WIDTH, HEIGHT calculate with ratio)
  ///
  /// - Parameters:
  ///     - dimension: this is new width
  ///     - opaque: this is new opaque for image
  ///     - contentMode: content mode
  func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
    var width: CGFloat
    var height: CGFloat
    var newImage: UIImage

    let size = self.size
    let aspectRatio =  size.width/size.height

    switch contentMode {
    case .scaleAspectFit:
      if aspectRatio > 1 {                            // Landscape image
        width = dimension
        height = dimension / aspectRatio
      } else {                                        // Portrait image
        height = dimension
        width = dimension * aspectRatio
      }

    default:
      fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
    }
    
    if #available(iOS 10.0, *) {
      let renderFormat = UIGraphicsImageRendererFormat.default()
      renderFormat.opaque = opaque
      let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
      newImage = renderer.image { _ in draw(in: CGRect(x: 0, y: 0, width: width, height: height)) }
    } else {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    return newImage
  }

  /// Set color for UIIMage
  ///
  /// - Parameters:
  ///     - color: new color
  func maskWithColor(color: UIColor) -> UIImage? {
    guard let maskImage = cgImage else { return nil }

    let width = size.width
    let height = size.height
    let bounds = CGRect(x: 0, y: 0, width: width, height: height)

    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let context = CGContext(
      data: nil,
      width: Int(width),
      height: Int(height),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: colorSpace,
      bitmapInfo: bitmapInfo.rawValue
    )

    context?.clip(to: bounds, mask: maskImage)
    context?.setFillColor(color.cgColor)
    context?.fill(bounds)

    if let cgImage = context?.makeImage() {
      return UIImage(cgImage: cgImage)
    } else {
      return nil
    }
  }

}
