//
//  MainTab.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import SwiftUI
import Home
import Favorit
import About

class MainTab: UITabBarController {
  
  init() {
    super.init(nibName: "MainTab", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavBar()
  }
  
  override func viewWillLayoutSubviews() {
    var tabFrame = self.tabBar.frame
    tabFrame.size.height = 80
    self.tabBar.frame = tabFrame
  }
  
  func configureNavBar() {
    tabBar.isTranslucent = false
    tabBar.barTintColor = .white
    tabBar.tintColor = .white
    tabBar.backgroundColor = .white
    
    let homeUsecase = Injection.init().homeProvideUseCase()
    let favoritUsecase = Injection.init().favoritProvideUseCase()
    let homePresenter = HomePresenter(useCase: homeUsecase)
    let favoritPresenter = FavoritPresenter(useCase: favoritUsecase)
    
    let home = createTabController(vc: HomeViewController(homePresenter: homePresenter, favoritPresenter: favoritPresenter), title: "Home", active: UIImage(named: "home-active"), inactive: UIImage(named: "home-inactive"))
    let favorite = createTabController(vc: FavoriteViewController(favoritPresenter: favoritPresenter), title: "Favorite", active: UIImage(named: "favorite-active"), inactive: UIImage(named: "favorite-inactive"))
    let about = createTabController(vc: AboutViewController(), title: "About", active: UIImage(named: "user-active"), inactive: UIImage(named: "user-inactive"))
    viewControllers = [home, favorite, about]
    self.delegate = self
  }
}

extension UITabBarController {
  func createTabController(vc: UIViewController, title: String, active: UIImage?, inactive: UIImage?) -> UINavigationController {
    
    let tabController = UINavigationController(rootViewController: vc)
    tabController.tabBarItem.image = inactive?.withRenderingMode(.alwaysOriginal)
    tabController.tabBarItem.selectedImage = active?.withRenderingMode(.alwaysOriginal)
    tabController.tabBarItem.title = title
    tabController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -4.0)
    tabController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(red: 0 / 255.0, green: 59.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0), NSAttributedString.Key.font: regularApplicationFont(withSize: 12)], for: .normal)
    tabController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(red: 102 / 255.0, green: 165 / 255.0, blue: 173 / 255.0, alpha: 1.0), NSAttributedString.Key.font: regularApplicationFont(withSize: 12)], for: .selected)
    
    return tabController
  }
  
  func regularApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Inter-Regular", size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
}

extension MainTab: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    
  }
  
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    guard let viewControllers = viewControllers else { return false }
    if viewController == viewControllers[selectedIndex] {
      if let nav = viewController as? UINavigationController {
        guard nav.viewControllers.last != nil else { return true }
        nav.popViewController(animated: true)
        return true
      }
    }
    
    return true
  }
}
