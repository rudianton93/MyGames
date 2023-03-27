//
//  FavoritRepositoryProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Core

public protocol FavoritRepositoryProtocol {
  
  func getDataGames(search: String, completion: @escaping (DataGames) -> ())
  func getDataFavorit(completion: @escaping(_ favorits: [Favorit]) -> Void)
  func getDataSameId(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void)
  func addDataFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteDataFavorit(_ id: Int64, completion: @escaping() -> Void)
}
