//
//  FavoritPresenterProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation

protocol FavoritPresenterProtocol {
  
  func requestGetData(search: String)
  func requestGetFavorit()
  func requestGetSameId(_ id: Int64)
  func requestAddFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String)
  func requestDeleteFavorit(_ id: Int64)
 
}
