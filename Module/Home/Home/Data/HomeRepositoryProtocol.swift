//
//  HomeRepositoryProtocol.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//
import Core

public protocol HomeRepositoryProtocol {
 
  func getDataGames(search: String, completion: @escaping (DataGames) -> ())
 
}
