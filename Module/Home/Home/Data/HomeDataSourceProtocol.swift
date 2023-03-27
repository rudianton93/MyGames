//
//  HomeDataSourceProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Core

public protocol HomeDataSourceProtocol {
 
  func getDataFromSource(search: String, completion: @escaping (DataGames) -> ())
 
}
