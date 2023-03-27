//
//  Loading.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public class Indicator {
  public static let sharedInstance = Indicator()
  var blurImg = UIImageView()
  var indicatorView = UIActivityIndicatorView(style: .large)
  
  private init() {
    blurImg.frame = UIScreen.main.bounds
    blurImg.backgroundColor = UIColor.black
    blurImg.isUserInteractionEnabled = true
    blurImg.alpha = 0.3
    
    indicatorView.color = .white
  }
  
  public func show() {
    DispatchQueue.main.async( execute: {
      let scenes = UIApplication.shared.connectedScenes
      let windowScene = scenes.first as? UIWindowScene
      if let window = windowScene?.windows.first {
        window.addSubview(self.blurImg)
        window.addSubview(self.indicatorView)
        
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        self.indicatorView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
      }
      self.indicatorView.startAnimating()
    })
  }
  
  public func hide() {
    DispatchQueue.main.async( execute: {
      self.blurImg.removeFromSuperview()
      self.indicatorView.removeFromSuperview()
    })
  }
}

