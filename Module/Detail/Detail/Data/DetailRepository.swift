//
//  DetailRepository.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation

public class DetailRepository: DetailRepositoryProtocol {
 
  public let detailDataSource: DetailDataSourceProtocol
 
  public init(dataSource: DetailDataSourceProtocol) {
    self.detailDataSource = dataSource
  }
 
  public func getDetailGames(id: Int64, completion: @escaping (DetailGames) -> ()) {
    detailDataSource.getDetailFromSource(id: id, completion: { (json) in
      completion(json)
    })
  }
  
  public func getScreenshotsGames(id: Int64, completion: @escaping (DataScreenshots) -> ()) {
    detailDataSource.getScreenshotsFromSource(id: id, completion: { (json) in
      completion(json)
    })
  }
  
  public func addDataFavorit(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
    detailDataSource.addFavoritFromSource(data, genres, platforms, completion: {
      completion()
    })
  }
  
  public func deleteDataFavorit(_ id: Int64, completion: @escaping() -> Void) {
    detailDataSource.deleteFavoritFromSource(id, completion: {
      completion()
    })
  }
}
