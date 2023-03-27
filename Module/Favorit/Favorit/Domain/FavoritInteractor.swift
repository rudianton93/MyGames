//
//  FavoritInteractor.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation
import Core

public class FavoritInteractor: FavoritUseCase {
 
  private let favoritRepository: FavoritRepositoryProtocol
 
  public init(repository: FavoritRepositoryProtocol) {
    self.favoritRepository = repository
  }
  
 
  public func getData(search: String, completion: @escaping (DataGames) -> ()) {
    return favoritRepository.getDataGames(search: search, completion: { (json) in
      completion(json)
    })
  }
 
  public func getFavorit(completion: @escaping(_ favorits: [Favorit]) -> Void) {
    favoritRepository.getDataFavorit(completion: { (json) in
      completion(json)
    })
  }
  
  public func getSameId(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void) {
    favoritRepository.getDataSameId(id, completion: { (json) in
      completion(json)
    })
  }
  
  public func addFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
    favoritRepository.addDataFavorit(data, genres, platforms, completion: {
      completion()
    })
  }
  
  public func deleteFavorit(_ id: Int64, completion: @escaping() -> Void) {
    favoritRepository.deleteDataFavorit(id, completion: {
      completion()
    })
  }
 
}
