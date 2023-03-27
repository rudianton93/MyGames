//
//  HomePresenter.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation
import RxCocoa
import RxSwift
import Core

public class HomePresenter: HomePresenterProtocol {
 
  private let homeUseCase: HomeUseCase
  private let disposeBag = DisposeBag()
  
  public var isLoading: BehaviorRelay<Bool>
  public var dataGames: BehaviorRelay<DataGames?>
  var detailGame: Games?
 
  public init(useCase: HomeUseCase) {
    self.homeUseCase = useCase
    isLoading = BehaviorRelay(value: false)
    dataGames = BehaviorRelay(value: nil)
  }
  
  public func requestGetData(search: String) {
    self.isLoading.accept(true)
    return homeUseCase.getData(search: search, completion: { (json) in
      self.isLoading.accept(false)
      self.dataGames.accept(json)
    })
  }
  
  func getPlatforms(data: [Platforms]) -> String {
    var listPlatforms = ""
    for index in 0...data.count - 1 {
      listPlatforms += "\(data[index].platform?.name ?? "")"
      listPlatforms += index == data.count - 1 ? " " : ", "
    }
    return listPlatforms
  }
 
}
