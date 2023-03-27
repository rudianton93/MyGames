//
//  HomeInteractor.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//
import Core

class HomeInteractor: HomeUseCase {
 
  private let homeRepository: HomeRepositoryProtocol
 
  init(repository: HomeRepositoryProtocol) {
    self.homeRepository = repository
  }
 
  func getData(search: String, completion: @escaping (DataGames) -> ()) {
    return homeRepository.getDataGames(search: search, completion: { (json) in
      completion(json)
    })
  }
 
}
