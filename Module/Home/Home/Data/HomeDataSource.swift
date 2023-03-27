//
//  HomeDataSource.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation
import RxAlamofire
import RxSwift
import Core

class HomeDataSource: HomeDataSourceProtocol {
  
  private let disposeBag = DisposeBag()
  
  func getDataFromSource(search: String, completion: @escaping (DataGames) -> ()) {
    let urlString = "\(GlobalFunction.baseUrl)"
    let parameters = ["key": "\(GlobalFunction.apiKey)", "search": "\(search)"]
    
    RxAlamofire.json(.get, urlString, parameters: parameters).debug()
      .subscribe(onNext: {(response) in
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else {return print("error with data")}
        guard let json: DataGames = try? decoder.decode(DataGames.self, from: jsonData) else {return print("error with json")}
        completion(json)
      }).disposed(by: disposeBag)
  }
 
}
