//
//  Injection.swift
//  Favorit
//
//  Created by Rudi Anton on 24/03/23.
//

public final class FavoritInjection: NSObject {
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
