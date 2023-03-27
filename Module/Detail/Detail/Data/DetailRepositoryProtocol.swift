//
//  DetailRepositoryProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation

public protocol DetailRepositoryProtocol {
  func getDetailGames(id: Int64, completion: @escaping (DetailGames) -> ())
  func getScreenshotsGames(id: Int64, completion: @escaping (DataScreenshots) -> ())
  func addDataFavorit(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteDataFavorit(_ id: Int64, completion: @escaping() -> Void)
}
