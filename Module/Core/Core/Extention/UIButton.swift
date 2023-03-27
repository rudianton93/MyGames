//
//  UIButton.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

extension UIButton {
  public func addShadow() {
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17).cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSize(width: 2, height: 4)
    self.layer.shadowRadius = 6
  }
}
