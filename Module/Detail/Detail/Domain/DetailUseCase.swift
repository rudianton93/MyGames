//
//  DetailUseCase.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation

public protocol DetailUseCase {
 
  func getDetail(id: Int64, completion: @escaping (DetailGames) -> ())
  func getScreenshots(id: Int64, completion: @escaping (DataScreenshots) -> ())
  func addFavorit(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void)
  func deleteFavorit(_ id: Int64, completion: @escaping() -> Void)
 
}
