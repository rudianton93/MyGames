//
//  UIImage.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

extension UIImage {
  public func resizeImg(targetSize: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size: targetSize).image { _ in
      self.draw(in: CGRect(origin: .zero, size: targetSize))
    }
  }
}
