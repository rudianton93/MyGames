//
//  UIFont.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public extension UIFont {
  class func lightApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: Constants.Fonts.light, size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
  
  class func regularApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: Constants.Fonts.regular, size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
  
  class func mediumApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: Constants.Fonts.medium, size: size) else {
      return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
    return font
  }
  
  class func boldApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: Constants.Fonts.bold, size: size) else {
      return UIFont.boldSystemFont(ofSize: size)
    }
    return font
  }
  
  static func boldFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Roboto-Bold", size: size) else {
      return UIFont.boldSystemFont(ofSize: size)
    }
    return font
  }
}
