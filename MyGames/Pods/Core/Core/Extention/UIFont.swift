//
//  UIFont.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public extension UIFont {
  static func boldFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Roboto-Bold", size: size) else {
      return UIFont.boldSystemFont(ofSize: size)
    }
    return font
  }
}
