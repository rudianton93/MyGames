//
//  DetailDataSourceProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation

public protocol DetailDataSourceProtocol {
 
  func getDetailFromSource(id: Int64, completion: @escaping (DetailGames) -> ())
  func getScreenshotsFromSource(id: Int64, completion: @escaping (DataScreenshots) -> ())
  func addFavoritFromSource(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteFavoritFromSource(_ id: Int64, completion: @escaping() -> Void)
 
}
