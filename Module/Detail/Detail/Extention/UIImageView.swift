//
//  UIImageView.swift
//  Detail
//
//  Created by Rudi Anton on 27/03/23.
//

import UIKit
import Kingfisher

extension UIImageView {
  public func setImage(urlString: String) {
    guard let url = URL(string: urlString) else {
      return
    }
    self.kf.setImage(with: url)
  }
}
