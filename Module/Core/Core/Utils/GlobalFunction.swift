//
//  GlobalFunction.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public struct GlobalFunction {
  
  public static let apiKey = "9fcb00d35cee4487bc6d93cc24b06016"
  public static let baseUrl = "https://api.rawg.io/api/games"
  
  public static func getImageFavoriteSelected() -> UIImage {
    return UIImage(named: "icon-favorite-selected")?.resizeImg(targetSize: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysOriginal) ?? UIImage()
  }
  
  public static func getImageFavoriteDelected() -> UIImage {
    return UIImage(named: "icon-favorite-off")?.resizeImg(targetSize: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysOriginal) ?? UIImage()
  }
}
