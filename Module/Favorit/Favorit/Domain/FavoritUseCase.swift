//
//  FavoritUseCase.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation
import Core

public protocol FavoritUseCase {
  
  func getData(search: String, completion: @escaping (DataGames) -> ())
  func getFavorit(completion: @escaping(_ favorits: [Favorit]) -> Void)
  func getSameId(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void)
  func addFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteFavorit(_ id: Int64, completion: @escaping() -> Void)
 
}
