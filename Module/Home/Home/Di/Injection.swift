//
//  Injection.swift
//  Home
//
//  Created by Rudi Anton on 24/03/23.
//

import Detail
import Favorit

public final class Injection: NSObject {
  
  public func homeProvideDataSource() -> HomeDataSourceProtocol {
    return HomeDataSource()
  }
  
  public func homeProvideRepository() -> HomeRepositoryProtocol {
    let homeDataSource = homeProvideDataSource()
    return HomeRepository(dataSource: homeDataSource)
  }
  
  public func homeProvideUseCase() -> HomeUseCase {
    let homeRepository = homeProvideRepository()
    return HomeInteractor(repository: homeRepository)
  }
  
  public func detailProvideDataSource() -> DetailDataSourceProtocol {
    return DetailDataSource()
  }
  
  public func detailProvideRepository() -> DetailRepositoryProtocol {
    let detailDataSource = detailProvideDataSource()
    return DetailRepository(dataSource: detailDataSource)
  }
  
  public func detailProvideUseCase() -> DetailUseCase {
    let detailRepository = detailProvideRepository()
    return DetailInteractor(repository: detailRepository)
  }
  
  public func favoritProvideDataSource() -> FavoritDataSourceProtocol {
    return FavoritDataSource()
  }
  
  public func favoritProvideRepository() -> FavoritRepositoryProtocol {
    let favoritDataSource = favoritProvideDataSource()
    return FavoritRepository(dataSource: favoritDataSource)
  }
  
  public func favoritProvideUseCase() -> FavoritUseCase {
    let favoritRepository = favoritProvideRepository()
    return FavoritInteractor(repository: favoritRepository)
  }
}
