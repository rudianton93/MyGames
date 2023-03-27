//
//  HomeUseCase.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Core

public protocol HomeUseCase {
 
  func getData(search: String, completion: @escaping (DataGames) -> ())
 
}
