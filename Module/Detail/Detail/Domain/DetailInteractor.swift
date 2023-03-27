//
//  DetailInteractor.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation

public class DetailInteractor: DetailUseCase {
 
  private let detailRepository: DetailRepositoryProtocol
 
  public init(repository: DetailRepositoryProtocol) {
    self.detailRepository = repository
  }
 
  public func getDetail(id: Int64, completion: @escaping (DetailGames) -> ()) {
    return detailRepository.getDetailGames(id: id, completion: { (json) in
      completion(json)
    })
  }
  
  public func getScreenshots(id: Int64, completion: @escaping (DataScreenshots) -> ()) {
    return detailRepository.getScreenshotsGames(id: id, completion: { (json) in
      completion(json)
    })
  }
  
  public func addFavorit(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
    detailRepository.addDataFavorit(data, genres, platforms, completion: {
      completion()
    })
  }
  
  public func deleteFavorit(_ id: Int64, completion: @escaping() -> Void) {
    detailRepository.deleteDataFavorit(id, completion: {
      completion()
    })
  }
}
