//
//  FavoritDataSourceProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation
import Core

public protocol FavoritDataSourceProtocol {
  
  func getDataFromSource(search: String, completion: @escaping (DataGames) -> ())
  func getFavoritFromSource(completion: @escaping(_ favorits: [Favorit]) -> Void)
  func getSameIdFromSource(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void)
  func addFavoritFromSource(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteFavoritFromSource(_ id: Int64, completion: @escaping() -> Void)
  
}
