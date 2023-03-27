//
//  Constants.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public struct Constants {
  public struct Fonts {
    public static let light    =  "Inter-Light"
    public static let regular  =  "Inter-Regular"
    public static let medium   =  "Inter-Medium"
    public static let bold     =  "Inter-Bold"
  }
  
  public struct TabbarImage {
    public static let favoriteActive   = UIImage(named: "favorite-active")
    public static let favoriteInactive = UIImage(named: "favorite-inactive")
    public static let homeActive     = UIImage(named: "home-active")
    public static let homeInactive   = UIImage(named: "home-inactive")
    public static let userActive    = UIImage(named: "user-active")
    public static let userInactive  = UIImage(named: "user-inactive")
  }
  
  public struct Color {
    public static let tabNormal      = UIColor(red: 0 / 255.0, green: 59.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    public static let tabSelected    = UIColor(red: 102 / 255.0, green: 165 / 255.0, blue: 173 / 255.0, alpha: 1.0)
  }
  
  public struct Image {
    public static let profile   = UIImage(named: "PhotoProfile")
    public static let search  = UIImage(named: "search")
    public static let iconSelected  = UIImage(named: "icon-favorite-selected")
  }
}
