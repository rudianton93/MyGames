//
//  FavoritRepository.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Core

public class FavoritRepository: FavoritRepositoryProtocol {
 
  private let favoritDataSource: FavoritDataSourceProtocol
 
  public init(dataSource: FavoritDataSourceProtocol) {
    self.favoritDataSource = dataSource
  }
  
  public func getDataGames(search: String, completion: @escaping (DataGames) -> ()) {
     favoritDataSource.getDataFromSource(search: search, completion: { (json) in
       completion(json)
     })
   }
 
  public func getDataFavorit(completion: @escaping(_ favorits: [Favorit]) -> Void) {
    favoritDataSource.getFavoritFromSource(completion: { (json) in
      completion(json)
    })
  }
  
  public func getDataSameId(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void) {
    favoritDataSource.getSameIdFromSource(id, completion: { (json) in
      completion(json)
    })
  }
  
  public func addDataFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
    favoritDataSource.addFavoritFromSource(data, genres, platforms, completion: {
      completion()
    })
  }
  
  public func deleteDataFavorit(_ id: Int64, completion: @escaping() -> Void) {
    favoritDataSource.deleteFavoritFromSource(id, completion: {
      completion()
    })
  }
 
}
