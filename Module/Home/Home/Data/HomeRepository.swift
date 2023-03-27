//
//  HomeRepository.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Core

class HomeRepository: HomeRepositoryProtocol {
 
  private let homeDataSource: HomeDataSourceProtocol
 
  init(dataSource: HomeDataSourceProtocol) {
    self.homeDataSource = dataSource
  }
 
  func getDataGames(search: String, completion: @escaping (DataGames) -> ()) {
    homeDataSource.getDataFromSource(search: search, completion: { (json) in
      completion(json)
    })
  }
 
}
